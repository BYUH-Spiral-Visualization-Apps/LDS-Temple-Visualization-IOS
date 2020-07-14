//
//  MainScreenView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


// use screen Height to set how much space each view should take on the screen
public var screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
public var screenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
public var centerX = screenWidth / 2
public var centerY = screenHeight * 0.8 / 2


//let statusbarHeight = UIApplication.shared.st


struct MainScreenView: View {
//
//    @Binding var mode: String
//    @Binding var hasAnimation: Bool
//
    
//    @State var mode: String = "default"
//    @State var hasAnimation: Bool = true
    
    
    //@EnvironmentObject var settings: SettingValues
    
        
//    func getAppTitle() -> String {
//        var title = settings.appTitle
//        return title
//    }
    
    
    //UIDevice.current.orientation.isPortrait
   
    
    
    
    var body: some View {
        

            NavigationView {
            SpiralView()
                //.frame(width: screenWidth, height: screenHeight, alignment: Alignment.center)
                .background(Color.gray)
                .navigationBarTitle("Latter-day Temples", displayMode: .inline)
                .navigationBarItems(trailing:
                                        NavigationLink(destination: SettingView()) {
                                            Image(systemName: "ellipsis.circle.fill")
                                        }
                                            

            )
        }
    }
}


struct SpiralView: View {

    
    //@EnvironmentObject var deviceOrientationEnv: DeviceOrientationEnv
    
    
    // we make this observed object,
    // along with its published spiral model in its class,
    // this view will update when changes happen to the model 
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()

    //screenWidth: SharedValues.screenWidth, screenHeight: SharedValues.screenHeight, centerX: SharedValues.centerX, centerY: SharedValues.centerY
    
    @EnvironmentObject var sharedValues: SharedValues
    
    
    func drawTemple(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            // temple content is a string which is name of image
            
            temple.content
                .resizable()
                .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                .position(x: temple.x, y: temple.y)
                .animation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation)
                .onTapGesture {
                    //print(temple)
                    //imageSpiralViewModel.choose(temple: temple)
                    //print(temple.year)
                    //temple.content.resizable().frame(width: screenWidth, height: screenWidth, alignment: Alignment.center)
                    
                    imageSpiralViewModel.changeATemple(id: temple.id)
                    
                    print(screenWidth)
                    print(sharedValues.orientation.rawValue)
                   
                    if (temple.tapped == true) {
                        SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                            sharedValues.oneTempleInfo.removeAll()
                            
                            sharedValues.tappedATemple = false
                            
                        }
                    } else {
                        SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.myAnimation : sharedValues.myNoAnimation) {
                            sharedValues.oneTempleInfo = imageSpiralViewModel.readOneTempleInfoFromFile(fileName: temple.fileName)
                            
                            sharedValues.tappedATemple = true
                            sharedValues.currentTappedTempleName = temple.name
                 
                            print(sharedValues.currentTappedTempleName)
                        }
                        //print(oneTempleInfo)
                    }
                    
                    
                }
            
        }
        
        return body
    }
    
    
    var body: some View {
        
        VStack {
        
            ZStack {
                ForEach(imageSpiralViewModel.onScreenTemples) {temple in
                    drawTemple(temple: temple)
                    // this line shows us how the spiral looks like on screen
                    //spiralDrawing().stroke()
                }
            }
               
            .frame(width: screenWidth, height: screenHeight * 0.75, alignment: Alignment.center)
            //.background(Color.green)
            // we need this background color for testing purposes
            
            Spacer(minLength: 0)
            
            
            
            if sharedValues.oneTempleInfo.count == 0 {
                
               
                    
                YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
                    .frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center)
                    //.background(Color.blue)
                    // we need this background color for testing purposes
                 
                Spacer(minLength: 0)

                SliderView(imageSpiralViewModel: imageSpiralViewModel)
                    .frame(width: screenWidth, height: screenHeight * 0.1, alignment: Alignment.center)
                    //.background(Color.green)
                    // we need this background color for testing purposes
                
                
            } else {
                MileStoneDatesView()
                    .frame(width: screenWidth, height: screenHeight * 0.25, alignment: Alignment.center)
                    
            }
            
            Rectangle()
                .background(Color.gray)
            
        }
        
        
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
