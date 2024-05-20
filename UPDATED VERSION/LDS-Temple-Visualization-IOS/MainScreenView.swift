//
//  MainScreenView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by Litian Zhang on 6/29/20.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

public var currentScreenWidthPublic: CGFloat = 0
public var currentScreenHeighPublic: CGFloat = 0
public var orientationInTextPublic: String = " "

// localizing all temple info files and adding their Chinese translation is now finished

struct MainScreenView: View {
    
    
    @EnvironmentObject var sharedValues: SharedValues
    
    
//    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral(centerX: SharedValues().centerX, centerY: SharedValues().centerY, screenWidth: SharedValues().screenWidth, screenHeight: SharedValues().screenHeight)
    @ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    
    //@State var showYearPicker = false
        
    
    @Environment(\.colorScheme) var colorScheme
    
    func buttonToSelector() -> some View {
        var body: some View {
            Button(action: {
                self.sharedValues.showSelector.toggle()
                self.sharedValues.showYearPicker = false
                self.sharedValues.showNameSearcher = false
                self.sharedValues.yearSet = false
                self.sharedValues.templeNameSet = false
                    }) {
                ZStack {
                    Rectangle().foregroundColor(Color.green.opacity(0))
                        .frame(width: 40, height: 40, alignment:.center)
                    Image(systemName: "magnifyingglass.circle.fill")
                }
                
            }.sheet(isPresented: $sharedValues.showSelector
                    , onDismiss: {
                        // if user goes to year picker, but did not move the picker, the value here is not changed its still -1
                        // it shows 1836 on year picker, if this happends, we set it to 0,
                        //if sharedValues.selectedYearIndex == -1 {
                            //sharedValues.selectedYearIndex = 52
                        //}
                        
                        
                        //print("sheet gone by swiping down")
                        //print("selectedYear is \(ImageSpiral.templeYears[sharedValues.selectedYearIndex])")
//                                print("selectedYear length is \(ImageSpiral.templeYears.count)")
//                                print(ImageSpiral.templeYears)
//                                print("theta now is \(sharedValues.sliderProgress)")
                        
                        // we are not doing anything here,
                        // wheather year set, is determined by only the buttons in year picker view 
                        
                        //print("new theta now is \(newThetaFromYearPicker)")
                        
//                        if imageSpiralViewModel.mode != sharedValues.mode {
//                            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
//                        }
                        
                        
                
                    }
            ) {
                //YearPicker(imageSpiralViewModel: self.imageSpiralViewModel).environmentObject(self.sharedValues)
                //SearchView(imageSpiralViewModel: self.imageSpiralViewModel).environmentObject(self.sharedValues)
                SelectorsView(imageSpiralViewModel: self.imageSpiralViewModel).environmentObject(self.sharedValues)
                
                    }
        }
        return body
    }
    
    
    func returnButtonFromLargeTemple() -> some View {
        var body: some View {
            Button(action: {
                //print("pressed return button from large temple")
                SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                    self.imageSpiralViewModel.changeATemple(id: self.sharedValues.currentTappedTempleId)
                    self.sharedValues.tappedATemple = false
                    self.sharedValues.singleTempleShow = false
                    self.sharedValues.spiralViewHeight = 0.75
                    self.sharedValues.mileStoneDatesViewHeight = 0.25
                    self.sharedValues.lastX = centerX
                    self.sharedValues.lastY = centerY
                    self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sharedValues.sliderProgress) // use this to restore everything
                }
                
                    }) {
                ZStack {
                    Rectangle().foregroundColor(Color.green.opacity(0))
                        .frame(width: 40, height: 40, alignment:.center)
                    Image(systemName: "arrowshape.turn.up.left.circle")
                        //.resizable()
                        //.frame(width: 30, height: 30, alignment:.center)
                        
                }
                
            }
            
        }
        return body
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                SpiralView(imageSpiralViewModel: imageSpiralViewModel)
                    //.frame(width: screenWidth, height: screenHeight, alignment: Alignment.center)
                    //.background(Color.gray)
                    .navigationBarTitle("app.title", displayMode: .inline)
                    .navigationBarItems(
                        leading: //buttonToYearPicker(),
                            HStack {
                                if sharedValues.tappedATemple {
                                    returnButtonFromLargeTemple()
                                } else {
                                    buttonToSelector()
                                }
                            }
                        
                        ,
                        trailing:
                            NavigationLink(destination: SettingView(imageSpiralViewModel: imageSpiralViewModel)) {
                                ZStack {
                                    Rectangle().foregroundColor(Color.green.opacity(0))
                                        .frame(width: 40, height: 40, alignment:.center)
                                    Image(systemName: "ellipsis.circle.fill")
                                }
                        }
                    )
            }
            .navigationViewStyle(StackNavigationViewStyle())
            
            
        }
        //.environment(\.locale, .init(identifier: "zh"))
        //.foregroundColor(Color.red)
        
    }
    
}



struct SpiralView: View {

    // we make this observed object,
    // along with its published spiral model in its class,
    // this view will update when changes happen to the model 
    //@ObservedObject var imageSpiralViewModel: ImageSpiral = ImageSpiral()
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @Environment(\.colorScheme) var colorScheme
    
    // we use computed value, we do this so that we can use sharefValues above
    var currentScreenWidth: CGFloat {
        get {
            currentScreenWidthPublic = sharedValues.currentScreenWidth
            currentScreenHeighPublic = sharedValues.currentScreenHeight
            orientationInTextPublic = sharedValues.orientationInText
            //print("new screen width: \(sharedValues.currentScreenWidth)")
            return sharedValues.currentScreenWidth
        }
    }
    
    var currentScreenHeight: CGFloat {
        get {
            //print("new screen height: \(sharedValues.currentScreenHeight)")
            return sharedValues.currentScreenHeight
        }
    }
    
    
//    var animationGoingOn: Bool {
//        get {
//            return sharedValues.animationInProgress
//        }
//    }

    
    // this struct is to check if animation ends
    // this is from online, so i still have questions about the logics in here...
    struct AnimatableModifierHere: AnimatableModifier {

        var targetValue: CGFloat
        
        // SwiftUI gradually varies it from old value to the new value
        var animatableData: CGFloat {
            didSet {
                //print("animatableData is \(animatableData)")
                //print("targetValue is \(targetValue)")
                checkIfFinished()
            }
        }

        var completion: () -> ()

        // Re-created every time the control argument changes
        init(bindedValue: CGFloat, completion: @escaping () -> ()) {
            self.completion = completion

            // Set animatableData to the new value. But SwiftUI again directly
            // and gradually varies the value while the body
            // is being called to animate. Following line serves the purpose of
            // associating the extenal argument with the animatableData.
            self.animatableData = bindedValue
            targetValue = bindedValue
            
        }

        func checkIfFinished() -> () {
            //print("Current value: \(animatableData)")
            //print("checkIfFinished in animatable modifier called")
            if (animatableData == targetValue) {
                //if animatableData.isEqual(to: targetValue) {
                DispatchQueue.main.async {
                    self.completion()
                }
            }
        }

        // Called after each gradual change in animatableData to allow the
        // modifier to animate
        func body(content: Content) -> some View {
            // content is the view on which .modifier is applied
            content
            // We don't want the system also to
            // implicitly animate default system animatons it each time we set it. It will also cancel
            // out other implicit animations now present on the content.
                //.animation(.none)
        }
    }
    
    func dragOnChangeActionInSpiralView(value: DragGesture.Value, temple: Spiral<Image>.Temple) {
        sharedValues.fingerTouchingScreen = true
        
        //print("last location is \(sharedValues.touchScreenLastX) \(sharedValues.touchScreenLastY)" )
        //print("onChanged \(value.location) \(value.translation)")
        
        if sharedValues.rememberFirstTouchLocation == false {
            sharedValues.touchScreenLastX = value.location.x
            sharedValues.touchScreenLastY = value.location.y
            sharedValues.rememberFirstTouchLocation = true
        }
        
        let xDirection = value.location.x - sharedValues.touchScreenLastX
        let yDirection = value.location.y - sharedValues.touchScreenLastY
        
        // let distanceFromTouchPointToCenter = sqrt(pow((value.location.x - centerX), 2) + pow((value.location.y - centerY), 2))
        
        let disableDragAreaInCenterSize: CGFloat = 4
        
        if value.location.x <= centerX - (centerX * 1 / disableDragAreaInCenterSize) {
            //print("at left area")
            if yDirection > 0 {
                //print("anticlockwise sliderProgress ++++++")
                SpiralAntiClockwise(speed: yDirection)
            } else if yDirection < 0 {
                //print("clockwise sliderProgress ----------")
                SpiralClockwise(speed: yDirection)
            }
        } else if value.location.x >= centerX + (centerX * 1 / disableDragAreaInCenterSize) {
            //print("at right area")
            if yDirection > 0 {
                //print("clockwise sliderProgress ----------")
                SpiralClockwise(speed: yDirection)
            } else if yDirection < 0 {
                //print("anticlockwise sliderProgress ++++++")
                SpiralAntiClockwise(speed: yDirection)
            }
        } else if value.location.y <= centerY - (centerY * 1 / disableDragAreaInCenterSize) {
            //print("at top area")
            if xDirection > 0 {
                //print("clockwise sliderProgress ----------")
                SpiralClockwise(speed: xDirection)
            } else if xDirection < 0 {
                //print("anticlockwise sliderProgress ++++++")
                SpiralAntiClockwise(speed: xDirection)
            }
        } else if value.location.y >= centerY + (centerY * 1 / disableDragAreaInCenterSize) {
            //print("at bottom area")
            if xDirection > 0 {
                //print("anticlockwise sliderProgress ++++++")
                SpiralAntiClockwise(speed: xDirection)
            } else if xDirection < 0 {
                //print("clockwise sliderProgress ----------")
                SpiralClockwise(speed: xDirection)
            }
        }
        
        sharedValues.touchScreenLastX = value.location.x
        sharedValues.touchScreenLastY = value.location.y
        
        imageSpiralViewModel.thisTempleIsUsedForDraging(id: temple.id, name: temple.name)
    }
    
    func dragOnEndActionInSingleTempleView(temple: Spiral<Image>.Temple) {
        if temple.x >= centerX - temple.size / 2 && temple.x <= centerX + temple.size / 2 && temple.y >= 0 && temple.y <= centerY * 2 {
            imageSpiralViewModel.setTemple(id: temple.id, newX: centerX, newY: centerY, newSize: temple.size)
            
        } else {
            //imageSpiralViewModel.changeATemple(id: temple.id)
            
            if temple.x > centerX + temple.size / 2 {
                if temple.id > 0 {
                    sharedValues.sliderProgress -= 30
                    imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                    imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                    
                    imageSpiralViewModel.changeATemple(id: temple.id - 1)
                    
                    imageSpiralViewModel.setTemple(id: temple.id, newX: centerX * 5, newY: centerY, newSize: temple.size)
                    imageSpiralViewModel.setTemple(id: temple.id - 1, newX: -centerX * 2, newY: centerY, newSize: screenWidth * 0.9)
                    SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
                        imageSpiralViewModel.setTemple(id: temple.id - 1, newX: centerX, newY: centerY, newSize: temple.size + 1)
                    }
                    
                    sharedValues.oneTempleInfo = imageSpiralViewModel.readOneTempleInfoFromFile(fileName: imageSpiralViewModel.onScreenTemples[temple.id - 1].fileName)
                    sharedValues.currentTappedTempleName =  imageSpiralViewModel.onScreenTemples[temple.id - 1].name
                    sharedValues.currentTappedTempleId = imageSpiralViewModel.onScreenTemples[temple.id - 1].id
                    sharedValues.currentTappedTempleLink = imageSpiralViewModel.onScreenTemples[temple.id - 1].link
                } else {
                    imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                    imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                    SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
                        sharedValues.tappedATemple = false
                        sharedValues.singleTempleShow = false
                        //print("tap a large temple")
                        sharedValues.spiralViewHeight = 0.75
                        sharedValues.mileStoneDatesViewHeight = 0.25
                        sharedValues.lastX = centerX
                        sharedValues.lastY = centerY
                    }
                }
            } else if temple.x < centerX - temple.size / 2 {
                print(temple.id)
                if temple.id < sharedValues.numberOfTemples + 1  {
                    sharedValues.sliderProgress += 30
                    imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                    imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                    
                    imageSpiralViewModel.changeATemple(id: temple.id + 1)
                    
                    imageSpiralViewModel.setTemple(id: temple.id, newX: -centerX * 2, newY: centerY, newSize: temple.size)
                    imageSpiralViewModel.setTemple(id: temple.id + 1, newX: centerX * 5, newY: centerY, newSize: screenWidth * 0.9)
                    SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
                        imageSpiralViewModel.setTemple(id: temple.id + 1, newX: centerX, newY: centerY, newSize: temple.size + 1)
                    }
                    
                    sharedValues.oneTempleInfo = imageSpiralViewModel.readOneTempleInfoFromFile(fileName: imageSpiralViewModel.onScreenTemples[temple.id + 1].fileName)
                    sharedValues.currentTappedTempleName = imageSpiralViewModel.onScreenTemples[temple.id + 1].name
                    sharedValues.currentTappedTempleId = imageSpiralViewModel.onScreenTemples[temple.id + 1].id
                    sharedValues.currentTappedTempleLink = imageSpiralViewModel.onScreenTemples[temple.id + 1].link
                    
                } else {
                    imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                    imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                    SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
                        sharedValues.tappedATemple = false
                        sharedValues.singleTempleShow = false
                        //print("tap a large temple")
                        sharedValues.spiralViewHeight = 0.75
                        sharedValues.mileStoneDatesViewHeight = 0.25
                        sharedValues.lastX = centerX
                        sharedValues.lastY = centerY
                    }
                }
            } else {
                imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
                imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
                SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
                    sharedValues.tappedATemple = false
                    sharedValues.singleTempleShow = false
                    //print("tap a large temple")
                    sharedValues.spiralViewHeight = 0.75
                    sharedValues.mileStoneDatesViewHeight = 0.25
                    sharedValues.lastX = centerX
                    sharedValues.lastY = centerY
                }
            }
            
            
        }
        
        sharedValues.lastX = centerX
        sharedValues.lastY = centerY
    }
    
    // this function takes in one temple and draw it at a spicific location with a spicific size
    // animation, animation modifier(check if animation ends) and tap action are also implemented here
    func drawOneTemple(temple: Spiral<Image>.Temple) -> some View {
        var body: some View {
            ZStack {

                //if sharedValues.selectedYearIndex != -1 {
                if sharedValues.selectorSet == true {
                    
                    if self.sharedValues.yearSet {
                        if temple.year == ImageSpiral.templeYears[sharedValues.selectedYearIndex] {
                            Circle()
                            .fill(Color.green)
                            .frame(width: temple.size * 1.1, height: temple.size * 1.1, alignment: Alignment.center)
                            .position(x: temple.x, y: temple.y)
                        }
                    }
                    if self.sharedValues.templeNameSet {
                        if sharedValues.selectedTemple == temple.name {
                            Circle()
                                .fill(Color.green)
                                .frame(width: temple.size * 1.1, height: temple.size * 1.1, alignment: Alignment.center)
                                .position(x: temple.x, y: temple.y)
                        }
                    }
                    
                }
                //}
                
                temple.content
                    .resizable()
                    .frame(width: temple.size, height: temple.size, alignment: Alignment.center)
                    .position(x: temple.x, y: temple.y)
                    //.opacity(0.3)
                    //.shadow(radius: 10)
                    
                    .opacity(temple.templeOpacity)
                    
                    .gesture(DragGesture()
                                .onChanged { value in
                                    self.sharedValues.selectorSet = false
                                    
                                    if !self.sharedValues.tappedATemple {
                                        self.dragOnChangeActionInSpiralView(value: value, temple: temple)
                                    } else {
                                        print(value.translation) // complet feature!: view next or last temple by draging large temple circle on single temple view!
                                        self.imageSpiralViewModel.dragSingleTemple(id: temple.id, xChange: value.translation.width, yChange: value.translation.height, lastX: self.sharedValues.lastX, lastY: self.sharedValues.lastY)
                                        if self.sharedValues.mileStoneDatesViewOpacity == 0 {
                                        } else {
                                            SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                                                self.sharedValues.mileStoneDatesViewOpacity = 0
                                            }
                                        }
                                        
//                                        imageSpiralViewModel.setTemple(id: temple.id + 1, newX: 0, newY: 0, newSize: screenWidth * 0.9)
//                                        imageSpiralViewModel.setTemple(id: temple.id - 1, newX: 0, newY: 0, newSize: screenWidth * 0.9)
                                        
                                    }
                                    
                                }
                                .onEnded { value in
                                    if self.sharedValues.mileStoneDatesViewOpacity == 1 {
                                    } else {
                                        SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                                            self.sharedValues.mileStoneDatesViewOpacity = 1
                                        }
                                    }
                                    
//                                    print("onEnded")
//                                    print("centerX is \(centerX)")
//                                    print("centerY is \(centerY)")
//                                    print("currentScreenWidth is \(sharedValues.currentScreenWidth)")
//                                    print("currentScreenHeigth is \(sharedValues.currentScreenHeight)")
//                                    print("sliderProgress is \(sharedValues.sliderProgress)")

                                    if !self.sharedValues.tappedATemple {
                                        self.sharedValues.rememberFirstTouchLocation = false
                                        self.sharedValues.fingerTouchingScreen = false
                                    } else {
                                        self.dragOnEndActionInSingleTempleView(temple: temple)
                                    }
                                    
                                }
                    )
                    .onTapGesture {
                        
                        //print("tapped a temple")
                        //print("showName is \(temple.showName)")
                        
                        //sharedValues.selectedYearIndex = -1
                        
                        // when tapped, we need to change the tapped temple size and location,
                        // we tapped again, we need to change it back
                        // how to detect we are tapping it in spiral view or single view? logic is in the method
                        self.imageSpiralViewModel.changeATemple(id: temple.id)
                        //print("tapped temple Link is \(temple.link)")
                        if (temple.tapped == true) {
                            SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                                self.sharedValues.tappedATemple = false
                                self.sharedValues.singleTempleShow = false
                                //print("tap a large temple")
                                self.sharedValues.spiralViewHeight = 0.75
                                self.sharedValues.mileStoneDatesViewHeight = 0.25
                                self.sharedValues.lastX = centerX
                                self.sharedValues.lastY = centerY
                                self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sharedValues.sliderProgress) // use this to restore everything
                            }
                        } else {
                            SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                                self.sharedValues.tappedATemple = true
                                self.sharedValues.singleTempleShow = true
                                //print("tap a small temple")
                                self.sharedValues.spiralViewHeight = 0.6
                                self.sharedValues.mileStoneDatesViewHeight = 0.4
                            }
                            self.sharedValues.oneTempleInfo = self.imageSpiralViewModel.readOneTempleInfoFromFile(fileName: temple.fileName)
                            self.sharedValues.currentTappedTempleName = temple.name
                            self.sharedValues.currentTappedTempleId = temple.id
                            self.sharedValues.currentTappedTempleLink = temple.link
                            
//                            if temple.link == "no link" {
//                                sharedValues.thisTempleHasNoLink = true
//                            } else {
//                                sharedValues.thisTempleHasNoLink = false
//                            }
                            
                        }
                        //print("tapped temple's size is \(temple.size)")
                        //print(temple)
                        
//                        print("--------------------")
//                        print(sharedValues.currentTappedTempleName.replacingOccurrences(of: " ", with: "-"))
                    }
                
            }
            .animation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none)
//            .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {
//                //print("sharedValues.sliderProgress is \(sharedValues.sliderProgress)")
//                //print("sharedValues.lastSliderProgress is \(sharedValues.lastSliderProgress)")
//                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress)")
//                //print("sharedValues.bindedValueForAnimatableModifier is \(sharedValues.bindedValueForAnimatableModifier)")
//                //print("animatable modifier is called")
//                if sharedValues.animationInProgress {
//                    print("animation finished")
//                    sharedValues.animationInProgress = false
//                }
//                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
//            })
        }
        return body
    }
    

    
    // we used functions to return a value then use it later to avoid the expressing to be too long. expressing is too long will cause can't type check in reasonable amount of time error
    
    func showNameLabelCondition(temple: Spiral<Image>.Temple) -> Bool {
        temple.showName && !sharedValues.animationInProgress && sharedValues.showLabel && !sharedValues.tappedATemple && !sharedValues.fingerTouchingScreen
    }
    
    func showNameLabelContent(temple: Spiral<Image>.Temple) -> String {
        // handle the last few temples, where their images is just with their names on it,
        // we dont what to show the names, so we just used name as " "
        //print("showNameLabelContent called \(temple.location)")
        return
        //temple.link == "no link" ? "" :
            temple.location
        
        //"hihihi"
    }
    
    func showNameLabel(temple: Spiral<Image>.Temple) -> some View {
        
        
        
        let labelForegroundColor = colorScheme == .dark ? Color.black.opacity(0.4) : Color.white.opacity(0.4)
        
        
        return Text(showNameLabelContent(temple: temple))
            .frame(maxWidth: temple.size)
            .background(temple.link == "no link" ? RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green.opacity(0)) : RoundedRectangle(cornerRadius: 10).foregroundColor(labelForegroundColor))
            //colorScheme == .dark ? Color.black : Color.white
            .position(x: temple.x, y: temple.y + temple.size / 2 - 5)
            .font(.system(size: 10))
            .multilineTextAlignment(.center)
    }
    
    func SpiralClockwise(speed: CGFloat) {
        if sharedValues.sliderProgress - 1 <= 180 {
            sharedValues.sliderProgress = 180
        } else {
            sharedValues.sliderProgress -= abs(speed) / 3
        }
        
        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
    }
    
    func SpiralAntiClockwise(speed: CGFloat) {
        if sharedValues.sliderProgress + 1 >= 6980 + CGFloat((sharedValues.numberOfTemples - 226) * 30)  {
            sharedValues.sliderProgress = 6980 + CGFloat((sharedValues.numberOfTemples - 226) * 30)
        } else {
            sharedValues.sliderProgress += abs(speed) / 3
        }
        
        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
    }
    
    func drawTemples() -> some View {
        
        //print("app launchs here screen width and height \(UIScreen.main.bounds.size.width) \(UIScreen.main.bounds.size.height)")
        
        if sharedValues.orientationChanged == true {
            
            // we need this to keep the single temple view show after orientation changed.
            // we do this, we resume single temple view temple attributes into spiral view
            // then we do this again
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
            
            // when orientation changed, we need to relocate spiral with current center x and y and sizes
            imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
            sharedValues.orientationChanged = false
            //print("relocate spiral")
            
            // we do this above code again, after we relocate spiral, we bring up single temple view again by changeing the same temples attributes, such as x y and size
            if sharedValues.singleTempleShow {
                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
            }
            
            //print("changed a temple")
        }
        

        
        var body: some View {
            ZStack {
                
//                Rectangle()
//                    .foregroundColor(Color.green.opacity(1)) // we have to keep the opacity none 0, if it's 0, gesture won;t work on it.
//                    .onTapGesture {
//                        if (sharedValues.tappedATemple == true) {
//                            SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
//                                sharedValues.tappedATemple = false
//                                sharedValues.singleTempleShow = false
//                                //print("tap a large temple")
//                                sharedValues.spiralViewHeight = 0.75
//                                sharedValues.mileStoneDatesViewHeight = 0.25
//                                imageSpiralViewModel.changeATemple(id: sharedValues.currentTappedTempleId)
//                            }
//                        }
//                    }
                    
                ForEach(imageSpiralViewModel.onScreenTemples) { temple in
                    
//                    if temple.name != "No Temple" {
//                        drawOneTemple(temple: temple)
//                    }
                    
                    // how is this diffrent? when usings this, app is sososososososo slow!!! But now it's working, a few minutes ago, this was slow, the one above was faster!!!! Weird sososo
                    if temple.name == "No Temple" {
                        
                    } else {
                        self.drawOneTemple(temple: temple)
                    }
                    
                    
                    
                    // we need to write a spiralDrawing method to used this comments with the coordinates, this method will just draw spiral on screen, for testing purposes. not it's not working. keep it here just in case we need to see how spiral looks
                    // this line shows us how the spiral looks like on screen
                    //spiralDrawing().stroke()
                    //drawOneTempleName(temple: temple)
                    if self.showNameLabelCondition(temple: temple) {
                        self.showNameLabel(temple: temple)
                        
                    }
                    
                }
                
            }
            .background(Color.blue.opacity(0.0001)) // we need this, so that touch event on single temple view on non circle or text area can be recognized
            
            
            
            .modifier(AnimatableModifierHere(bindedValue: (sharedValues.showLabel && !sharedValues.fingerTouchingScreen) ? sharedValues.sliderProgress : 0) {
                //print("sharedValues.sliderProgress is \(sharedValues.sliderProgress)")
                //print("sharedValues.lastSliderProgress is \(sharedValues.lastSliderProgress)")
                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress)")
                //print("sharedValues.bindedValueForAnimatableModifier is \(sharedValues.bindedValueForAnimatableModifier)")
                //print("animatable modifier is called")
                if self.sharedValues.animationInProgress {
                    print("animation finished")
                    self.sharedValues.animationInProgress = false
                }
                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
            })
            // we do animation here so that label show and disappear is animiated, cant do it on Text within if (i dont know why)
            // we still need to animation in drawonetemple method.
            // we have to keep this default, even when the setting is off, otherwise, animation ends checking will not run, i do not know why
            // im assuming, guessing, when aniamtion on each temple is .none, this animation will be checked by animatable modifer to see if animation ends
            .animation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : Animation.linear(duration: 0.2))
//            .modifier(AnimatableModifierHere(bindedValue: sharedValues.sliderProgress) {
//                //(bindedValue: ((sharedValues.sliderProgress == sharedValues.lastSliderProgress && sharedValues.animationInProgress) ? sharedValues.sliderProgress : 0))
//
//                print("sharedValues.sliderProgress is \(sharedValues.sliderProgress)")
//                print("sharedValues.lastSliderProgress is \(sharedValues.lastSliderProgress)")
////                print("sharedValues.animationInProgress is \(sharedValues.animationInProgress)")
//
//                //print("sharedValues.bindedValueForAnimatableModifier is \(sharedValues.bindedValueForAnimatableModifier)")
//
//                print("animatable modifier is called")
//
//                //if sharedValues.sliderProgress == sharedValues.lastSliderProgress {
//                    sharedValues.animationInProgress = false
//                    print("animation finished")
//                //}
//
////                if sharedValues.animationInProgress {
////                    print("animation finished")
////                    sharedValues.animationInProgress = false
////                }
//                //print("sharedValues.animationInProgress is \(sharedValues.animationInProgress) ")
//
//            })
        }
        return body
    }
    
    func PortraitView() -> some View {
        
        var body: some View {
            VStack {
                drawTemples()
                .frame(width: currentScreenWidth, height: currentScreenHeight * sharedValues.spiralViewHeight, alignment: Alignment.center)
                
                Spacer(minLength: 0)
                
                // we show mile stone dates once a temple is tapped,
                if sharedValues.tappedATemple == false {
                    
                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
                        //.background(Color.green)
                        // leave this this background color comment here for testing purposes
      
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(width: currentScreenWidth, height: currentScreenHeight * sharedValues.mileStoneDatesViewHeight, alignment: Alignment.center)
                        .background(Color.red.opacity(0.0001))  // we need this, so that touch event on single temple view on non circle or text area can be recognized
                        
                }
                // if we put back ground color for spiral, we might need this to fill up the bottom,
                // no need this if we don't set any custome color, just use the default light and dart mode of ios
//                Rectangle()
//                    .foregroundColor(Color.gray)
            }

        }
        return body
}
    
    func LandscapeViewForPhone() -> some View {
        
        var body: some View {
            HStack {
                drawTemples()
                    .frame(width: currentScreenWidth / 2 , height: currentScreenHeight, alignment: Alignment.center)
                    //.background(Color.yellow)
                
                if sharedValues.tappedATemple == false {
                    GeometryReader { geometry in
                        VStack {
                            // be aware force slider size was causing me a HUGE bug. that's why we used geometry reader here
                            SliderView(imageSpiralViewModel: self.imageSpiralViewModel)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3, alignment: Alignment.center)
                                //.background(Color.red)
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.6)
                        }
                    }
                } else {
                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(maxHeight: currentScreenHeight * 0.5)
                        .background(Color.red.opacity(0.0001))  // we need this, so that touch event on single temple view on non circle or text area can be recognized
                        //.background(Color.purple)
                }
            }
        }
        return body
}
    
//    // this is very much like PortraitView
//    func LandscapeViewForPad() -> some View {
//
//        var body: some View {
//            VStack {
//
//                drawTemples()
//                    .frame(width: currentScreenWidth, height: currentScreenHeight * 0.75, alignment: Alignment.center)
//
//                Spacer(minLength: 0)
//
//                if sharedValues.tappedATemple == false {
//
//                    SliderView(imageSpiralViewModel: imageSpiralViewModel)
//                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
//                        //.background(Color.green)
//                        // leave this this background color comment here for testing purposes
//                } else {
//
//                    MileStoneDatesView(imageSpiralViewModel: imageSpiralViewModel)
//                        .frame(width: currentScreenWidth, height: currentScreenHeight * 0.25, alignment: Alignment.center)
//                }
//            }
//        }
//
//        return body
//}
    
    var body: some View {
        return ZStack {
            
            // we are checking for unknow here, every time app launches, orientation is unknow,
            // here is a possible bug, don't know how to solve yet
            // even user launch app in landscape mode, portrait view will still show...
            if (sharedValues.orientationInText == "portrait" || sharedValues.orientationInText == "unknown") {
                PortraitView()
            } else if (sharedValues.orientationInText == "landscape" || sharedValues.orientationInText == "unknown") {
                if sharedValues.currentDevice == .phone {
                    LandscapeViewForPhone()
                } else {
                    PortraitView() // landscape mode pad is the same as portrait
                    //PortraitView()
                }
            }
        }
        .onTapGesture {
            if (self.sharedValues.tappedATemple == true) {
                SwiftUI.withAnimation(self.sharedValues.animationOption == "slow" ? self.sharedValues.mySlowAnimation : self.sharedValues.animationOption == "fast" ? self.sharedValues.myFastAnimation : .none) {
                    self.sharedValues.tappedATemple = false
                    self.sharedValues.singleTempleShow = false
                    //print("tap a large temple")
                    self.sharedValues.spiralViewHeight = 0.75
                    self.sharedValues.mileStoneDatesViewHeight = 0.25
                    self.imageSpiralViewModel.changeATemple(id: self.sharedValues.currentTappedTempleId)
                    self.sharedValues.lastX = centerX
                    self.sharedValues.lastY = centerY
                    self.imageSpiralViewModel.getNewTheta(newTheta: self.sharedValues.sliderProgress)
                    self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sharedValues.sliderProgress)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
