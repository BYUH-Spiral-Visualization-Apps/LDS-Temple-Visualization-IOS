//
//  YearPicker.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/24.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct YearPicker: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var templeYears: Array<String> = ImageSpiral.templeYears
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    //@State var selectedYearIndex = 0
    
    let deviceLanguage = Locale.current.languageCode
    
    var body: some View {
        
        return GeometryReader { geometry in
            VStack {
                Spacer()
                
//                Image(systemName: "arrow.down")
//                    .font(.system(size: geometry.size.width * 0.1))
//                    .onTapGesture {
//                        sharedValues.showYearPicker.toggle()
//                        print("sheet gone clicking")
//                    }
                
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5)
//                        .size(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
//                    Text("View")
//                }
//                .onTapGesture {
//                    sharedValues.showYearPicker.toggle()
//                    print("sheet gone clicking")
//                }
                
                if self.sharedValues.selectedYearIndex == self.templeYears.count - 1 {
                    Text("announced.temples")
                } else if self.sharedValues.selectedYearIndex == self.templeYears.count - 2 {
                    Text("temples.under.construction")
                } else {
                    HStack {
                        if self.deviceLanguage == "zh" {
                            Text("\(ImageSpiral.templeYears[self.sharedValues.selectedYearIndex])")
                            + Text("temples.dedicated.in")
                        } else {
                            Text("temples.dedicated.in")
                            Text("\(ImageSpiral.templeYears[self.sharedValues.selectedYearIndex])")
                        }
                        
                    }
                }
                
                //if sharedValues.selectedYearIndex != -1 {
                // we cannot use this way to do if statement, because strings wont localize under this way
//                    Text(sharedValues.selectedYearIndex == templeYears.count - 1 ? "announced.temples" :
//                        sharedValues.selectedYearIndex == templeYears.count - 2 ? "temples.under.construction" : "temples.dedicated.in" + " \(ImageSpiral.templeYears[sharedValues.selectedYearIndex])")
                //} else {
                    //Text("Temples dedicated in 1836")
                //}
                
                //Spacer()
                
                Picker(selection: self.$sharedValues.selectedYearIndex, label: Text("")) {
                    ForEach(0 ..< self.templeYears.count,id: \.self) {
                                if self.templeYears[$0] == "0000" {
                                    Text("temples.under.construction.lower.case")
                                } else if self.templeYears[$0] == "1111" {
                                    Text("announced.temples.lower.case")
                                } else {
                                    Text(self.templeYears[$0])
                                }
                                
                                
                            }
                         }
                .labelsHidden()
                //.frame(width: geometry.size.width * 1, height: geometry.size.height * 0.5, alignment: Alignment.center)
                //.background(Color.red)
                //Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        //self.self.sharedValues.showSelector.toggle()
                        SwiftUI.withAnimation(.default) {
                            self.sharedValues.showYearPicker = false
                        }
                        //self.sharedValues.showNameSearcher = false
                    }) {
                        Text("back")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.self.sharedValues.showSelector.toggle()
                        self.self.sharedValues.selectorSet = true
                        let newThetaFromYearPicker: CGFloat = ImageSpiral.templeYearsThetaFriends[self.self.sharedValues.selectedYearIndex] + 20
                        self.self.sharedValues.sliderProgress = newThetaFromYearPicker
                        self.self.imageSpiralViewModel.getNewTheta(newTheta: newThetaFromYearPicker)
                        self.self.imageSpiralViewModel.updateOnScreenTemples(newTheta: newThetaFromYearPicker)
                        self.sharedValues.yearSet = true
                        
                        
                    }) {
                        Text("view")
                    }
                    Spacer()
                }
                Spacer()
           
                
            }
            //.background(Color.gray)
        
        }
        
        
    }
}

//struct YearPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        YearPicker()
//    }
//}
