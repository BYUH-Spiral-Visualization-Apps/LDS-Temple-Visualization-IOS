//
//  SettingValues.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import Foundation
import SwiftUI

public var screenWidth: CGFloat =
    (UIDevice.current.userInterfaceIdiom == .phone ?
        (//UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4
            UIApplication.shared.statusBarOrientation.isLandscape ?
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8 :
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) :
        (//UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4
            UIApplication.shared.statusBarOrientation.isLandscape ?
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.6 :
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7))

public var screenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
public var centerX: CGFloat = //500
    (UIDevice.current.userInterfaceIdiom == .phone ?
        (UIApplication.shared.statusBarOrientation.isLandscape ?
            max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 4 :
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.57) :
        (UIApplication.shared.statusBarOrientation.isLandscape ?
            max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2 :
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.57
        ))

public var centerY: CGFloat = //300
    (UIDevice.current.userInterfaceIdiom == .phone ?
        (UIApplication.shared.statusBarOrientation.isLandscape ?
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.55 :
            max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.4) :
        (UIApplication.shared.statusBarOrientation.isLandscape ?
            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.4 :
            max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.4
        ))


//private var screenWidth: CGFloat =
//    (UIDevice.current.userInterfaceIdiom == .phone ?
//        (UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 ?
//            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8 :
//            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)) :
//        (UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 ?
//            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.6 :
//            min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7))
//
//private var screenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
//private var centerX = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
//private var centerY = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8 / 2

//public var screenWidth
//
//public var screenHeight
//public var centerX
//public var centerY

//public var screenWidth:CGFloat {
//    get {
////        var temporaryValue: CGFloat = 0
////        if UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 {
////            temporaryValue = (UIDevice.current.userInterfaceIdiom == .phone ? min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) : min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7)
////        } else if UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 {
////            temporaryValue = (UIDevice.current.userInterfaceIdiom == .phone ? min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8 : min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.6)
////        } else if UIDevice.current.orientation.rawValue == 0 {
////            temporaryValue = 100
////        }
////        return temporaryValue
//
//        (UIDevice.current.userInterfaceIdiom == .phone ? min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) : min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7)
//
//    } set {
//
//    }
//}
//
//
//
//public var screenHeight:CGFloat {
//    get {
//        max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
//    } set {
//
//    }
//}
//
//public var centerX: CGFloat {
//    get {
//        min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 2
//    }
//    set {
//
//    }
//}
//public var centerY: CGFloat {
//    get {
//        max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8 / 2
//    }
//    set {
//
//    }
//}

var nonMainViewColorSchemaPublic = Color.gray

class SharedValues: ObservableObject {
    
//    @Published var screenWidth: CGFloat = 100
//    @Published var screenHeight: CGFloat = 100
//    @Published var centerX: CGFloat = 100
//    @Published var centerY: CGFloat = 100
    
    
    @Published var animationOption = "off"
    @Published var mode = "default"
    //@Published var showAbout = false
    
    @Published var nonMainViewColorSchema = nonMainViewColorSchemaPublic
    @Published var defaultColor = Color.blue
    @Published var spinColor = nonMainViewColorSchemaPublic
    @Published var threeDColor = nonMainViewColorSchemaPublic
    
    @Published var slowAnimationColor = nonMainViewColorSchemaPublic
    @Published var fastAnimationColor = nonMainViewColorSchemaPublic
    @Published var offAnimationColor = Color.blue
    
    @Published var showLabelOn = Color.blue
    @Published var showLabelOff = nonMainViewColorSchemaPublic
    
//    @Published var showLabelBackgroundYes = nonMainViewColorSchemaPublic
//    @Published var showLabelBackgroundNo = Color.blue
    
    @Published var selectedColor = Color.blue
    @Published var unSelectedColor = nonMainViewColorSchemaPublic
    
    @Published var tappedATemple = false
    @Published var currentTappedTempleName = " "
    @Published var currentTappedTempleId: Int = 0
    @Published var currentTappedTempleLink = " "
    
    @Published var templesList = "https://www.churchofjesuschrist.org/temples/list?lang=eng"
    
    //@Published var myVerySlowAnimation: Animation = Animation.linear(duration: 10)
    @Published var mySlowAnimation: Animation = Animation.linear(duration: 1)
    @Published var myFastAnimation: Animation = Animation.linear(duration: 0.5)
    @Published var myVeryFastAnimation: Animation = Animation.linear(duration: 0.05)
    
    @Published var showLabel = true // hello
    
    @Published var oneTempleInfo: Array<ImageSpiral.Info> = Array<ImageSpiral.Info>()
   
    @Published var numberOfTemples: Int = ImageSpiral.templeNames.count 
    @Published var sliderProgress: CGFloat = 5300
    @Published var lastSliderProgress: CGFloat = 5300
    //@Published var bindedValueForAnimatableModifier: CGFloat = 3000
    
    @Published var startYear: String = "2002"
    @Published var endYear: String = "2017"
    
    @Published var modeTest: String = "default"
    
    @Published var currentScreenWidth = UIScreen.main.bounds.size.width 
    @Published var currentScreenHeight = UIScreen.main.bounds.size.height
    
    @Published var singleTempleShow = false
    //@Published var thisTempleHasNoLink = true
    
    @Published var currentDevice = UIDevice.current.userInterfaceIdiom
    
    @Published var animationInProgress = false
    
    // these two value is binded to year picker in yearpickerview and left button on spiralview navigation bar
    // year is just 1836 + index 
    @Published var showSelector = false
    @Published var selectedYearIndex = 52
    @Published var selectorSet = false
    @Published var selectedTemple = ""
    @Published var showYearPicker = false
    @Published var showNameSearcher = false
    @Published var yearSet = false
    @Published var templeNameSet = false
    
    @Published var touchScreenLastX: CGFloat = 0
    @Published var touchScreenLastY: CGFloat = 0
    @Published var rememberFirstTouchLocation = false
    @Published var fingerTouchingScreen = false
    
    @Published var spiralViewHeight: CGFloat = 0.75
    @Published var mileStoneDatesViewHeight: CGFloat = 0.25
    
    @Published var lastX: CGFloat = centerX
    @Published var lastY: CGFloat = centerY
    @Published var mileStoneDatesViewOpacity: Double = 1
    
    
    @Published var orientation = UIDevice.current.orientation
    @Published var orientationChanged = false
    @Published var orientationInText = (UIDevice.current.orientation.rawValue == 0 ? (UIApplication.shared.statusBarOrientation.isLandscape ? "landscape" : "portrait") :
        UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 ? "portrait" :
        UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 ? "landscape" : (UIApplication.shared.statusBarOrientation.isLandscape ? "landscape" : "portrait"))
    var orientationRawValueHistory: Array<Int> = [UIDevice.current.orientation.rawValue]
  
    init() {
        // Detect device orientation
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
        //print("device rotation when app launch: \(orientationInText)")
    }
    
    
    //once orientation changed, this function will get called
    @objc func receivedRotation(){
        // orientaion here
        self.orientation = UIDevice.current.orientation

        print(self.orientationRawValueHistory)
        
        // convert orientaion code into text, we dont care about 5 and 6 which are face up and down
        // for 1, 2 and 3, 4. we treat them the same
        if UIDevice.current.orientation.rawValue == 0 {
            self.orientationInText = //"unknown"
            (UIApplication.shared.statusBarOrientation.isLandscape ? "landscape" : "portrait")
            if self.orientationRawValueHistory.contains(1) || self.orientationRawValueHistory.contains(2) {
                self.orientationInText = "portrait"
            } else if self.orientationRawValueHistory.contains(3) || self.orientationRawValueHistory.contains(4) {
                self.orientationInText = "landscape"
            }
        } else if UIDevice.current.orientation.rawValue == 1 || UIDevice.current.orientation.rawValue == 2 {
            self.orientationInText = "portrait"
        } else if UIDevice.current.orientation.rawValue == 3 || UIDevice.current.orientation.rawValue == 4 {
            self.orientationInText = "landscape"
        }
        print(self.orientationInText)
        
        // store current orientation in an array, we will need to check what last orientaion is once orientation changed
        orientationRawValueHistory.append(UIDevice.current.orientation.rawValue)
        
        //print("before \(orientationRawValueHistory)")
        
        // if changed to portrait, landscapes left or right, we only update if last orientation is landscapes or portrait respectively
        // we have a unsolved bug here, every time app launches, the orientation is unknow, which is 0, so that first time rotating, we cannot detect what last orientation is, portrait or landscape? so the view might look not in order, but that's only for the first time rotation. this does not seem to happen on the simulator, just on my device... maybe there is something wrong with my device, i hope so and not hope so ... 😂😂😂
        
        // if we rotate to portrait
        if orientationRawValueHistory[orientationRawValueHistory.count-1] == 1 ||
            orientationRawValueHistory[orientationRawValueHistory.count-1] == 2 {
            // if last orientain is landscape
            if orientationRawValueHistory.contains(3) || orientationRawValueHistory.contains(4) {
                // remove history for next check
                orientationRawValueHistory.removeAll()
                // orientaion really changed, for instance, not from landscape left to landscape right
                orientationChanged = true
            }
        // if we rotate to landscape
        } else if orientationRawValueHistory[orientationRawValueHistory.count-1] == 3 ||
                    orientationRawValueHistory[orientationRawValueHistory.count-1] == 4 {
            //if last orientaion is portrait
            if orientationRawValueHistory.contains(1) || orientationRawValueHistory.contains(2) {
                orientationRawValueHistory.removeAll()
                orientationChanged = true
                
  
            }
        }
        
        //print("after \(orientationRawValueHistory)")
        
        // remember last orientaions
        orientationRawValueHistory.append(UIDevice.current.orientation.rawValue)

        //print(self.orientationInText)
        
        if (self.orientationInText == "portrait") {
            //print("device rotates to portrait")
            currentScreenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            currentScreenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            
            if currentDevice == .phone {
                screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            } else if currentDevice == .pad {
                screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.7
            }
            
            centerX = currentScreenWidth * 0.57
            centerY = currentScreenHeight * 0.4
            
            lastX = centerX
            lastY = centerY

            
        } else if (self.orientationInText == "landscape") {
            //print("device rotates to landscape")
            currentScreenWidth = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            currentScreenHeight = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
            
            // in landscape mode, phone and pad will have different layout in spiral view
            if currentDevice == .phone {
                screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.8
                centerX = currentScreenWidth / 4
                centerY = currentScreenHeight * 0.55
                //centerY = currentScreenHeight * 0.5
            } else {
                screenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) * 0.6
                centerX = currentScreenWidth * 0.57
//                //centerY = currentScreenHeight * 0.5 //screenWidth * 0.8
                centerY = currentScreenHeight * 0.4
            }
            
            lastX = centerX
            lastY = centerY
        }
        
        //print(currentScreenWidth)
        //print(currentScreenHeight)
        
        //print("centerX and centerY once orientation changed: \(centerX), \(centerY)")
        
                switch UIDevice.current.orientation {
                case UIDeviceOrientation.unknown:
                    print("方向未知 \(UIDevice.current.orientation.rawValue)") // 0
                    print((UIDevice.current.orientation.rawValue == 0))
                case .portrait: // Device oriented vertically, home button on the bottom
                    print("屏幕直立 \(UIDevice.current.orientation.rawValue)") // 1
                case .portraitUpsideDown: // Device oriented vertically, home button on the top
                    print("屏幕倒立 \(UIDevice.current.orientation.rawValue)") // 2
                case .landscapeLeft: // Device oriented horizontally, home button on the right
                    print("屏幕左旋 \(UIDevice.current.orientation.rawValue)") // 3
                case .landscapeRight: // Device oriented horizontally, home button on the left
                    print("屏幕右旋 \(UIDevice.current.orientation.rawValue)") // 4
                case .faceUp: // Device oriented flat, face up
                    print("屏幕朝上 \(UIDevice.current.orientation.rawValue)") // 5
                case .faceDown: // Device oriented flat, face down
                    print("屏幕朝下 \(UIDevice.current.orientation.rawValue)") // 6
                @unknown default:
                    print("orientaion not being detected, may be added in furture versions")
                }
        
        //print(UIDevice.current.userInterfaceIdiom)
        if UIDevice.current.userInterfaceIdiom == .phone {
           print("running on iPhone")
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            print("running on iPad")
         }
        
    }
    
    
    
}
