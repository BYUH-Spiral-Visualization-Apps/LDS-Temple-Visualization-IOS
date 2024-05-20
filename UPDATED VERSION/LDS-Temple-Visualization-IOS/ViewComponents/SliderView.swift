//
//  SliderView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    
    
    // we update spiral here,
    // we call functions in imagespiral view mode to call functions in spiral mode, to change itself
    func updateSpiral() {
        imageSpiralViewModel.getNewTheta(newTheta: sharedValues.sliderProgress)
        imageSpiralViewModel.updateOnScreenTemples(newTheta: sharedValues.sliderProgress)
//
//        if imageSpiralViewModel.mode != sharedValues.mode {
//            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
//        }
        
        sharedValues.oneTempleInfo.removeAll()
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                HStack {
                    Image(systemName: "arrow.left.square.fill")
                        .onTapGesture {
                            self.sharedValues.animationInProgress = true
                            // we need to put this in withAnimation, so that we can check if the animation ends so that we can decide to display name label
                            //SwiftUI.withAnimation(.default) {
                            
                            if self.sharedValues.sliderProgress - 30 <= 180 {
                                self.sharedValues.sliderProgress = 180
                            } else {
                                self.sharedValues.sliderProgress -= 30
                            }
                            //}
                            self.updateSpiral()
                            
                            self.sharedValues.selectorSet = false
                            self.sharedValues.selectedYearIndex = 52
                        }
                    MySlider(imageSpiralViewModel: imageSpiralViewModel)
                        .frame(maxWidth: (min(sharedValues.currentScreenWidth, sharedValues.currentScreenHeight)) * 0.8)
                        //.background(Color.red)
                    Image(systemName: "arrow.right.square.fill")
                        .onTapGesture {
                            self.sharedValues.animationInProgress = true
                            //SwiftUI.withAnimation(.default) {
                            
                            if self.sharedValues.sliderProgress + 30 >= 6980 + CGFloat((sharedValues.numberOfTemples - 226) * 30) {
                                self.sharedValues.sliderProgress = 6980 + CGFloat((sharedValues.numberOfTemples - 226) * 30)
                            } else {
                                self.sharedValues.sliderProgress += 30
                            }
                            //}
                            self.updateSpiral()
                            
                            self.sharedValues.selectorSet = false
                            self.sharedValues.selectedYearIndex = 52
                        }
                }
            }
                
                            
//            YearDisplayView(startYear: ImageSpiral.startYearTest, endYear: ImageSpiral.endYearTest)
            YearDisplayView(startYear: sharedValues.startYear, endYear: sharedValues.endYear)
                //.background(Color.red)
                .padding()
            
            // we are not show the slider label in any situation anymore
//            HStack {
//                // we dont display slider label: start year and current year in landscape mode of phone, because of limited space
//                if sharedValues.currentDevice == .phone && sharedValues.orientationInText == "landscape" {
//                    // do nothing
//                } else {
//                    Text("1836")
//                        .padding()
//                }
//
//                YearDisplayView(startYear: ImageSpiral.startYear, endYear: ImageSpiral.endYear)
//                    //.background(Color.red)
//                    .padding()
//
//                if sharedValues.currentDevice == .phone && sharedValues.orientationInText == "landscape" {
//                    // do nothing
//                } else {
//                    Text("2020")
//                        .padding()
//                }
//            }
            
        }
    }
}

struct MySlider: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    func getStartAndEndYear(){
        var startYear = ""
        var endYear = ""
        var gotStartYear = false
        for i in imageSpiralViewModel.onScreenTemples {
            if i.year != "No Year" {
                if i.x <= sharedValues.currentScreenWidth {
                    if gotStartYear == false {
                        startYear = i.year
                        gotStartYear = true
                    }
                    endYear = i.year
                }
                
            }
            
        }
        sharedValues.startYear = startYear
        sharedValues.endYear = endYear
    }
    
    var body: some View {
        // we use Binding, so that when ever slider progress changes, we can do something
        Slider(value: Binding(
                get: {
                    //getStartAndEndYear()
                    return Double(self.sharedValues.sliderProgress)
                },
                set: {(newValue) in
                    
                    self.getStartAndEndYear()
                    
                    self.sharedValues.selectorSet = false
                    self.sharedValues.selectedYearIndex = 52
                    
                    self.sharedValues.lastSliderProgress = self.sharedValues.sliderProgress
                    
                    // only run the following code when sliderporgess changed
                    // if not checking newvalue and sliderprogress,
                    // newvalue might be the same as sliderprogress, these lines may excute too
                    // this might cause problems with checking if animation stops
                    
                    if CGFloat(newValue) != self.sharedValues.sliderProgress {
                        
                        
                        

//                        if sharedValues.animationInProgress != true {
// we don't need this anymore when we put animatable modifer on each temple to check if animation ends?... accidetally fixed label moving while appearing and disappearing bug...
//                            // we need to put this in withAnimation, so that we can check if the animation ends so that we can decide to display name label
//                            SwiftUI.withAnimation(.none) {
//                                sharedValues.sliderProgress = CGFloat(newValue)
//                            }
//                        }
//
                        self.sharedValues.animationInProgress = true
                        
                        //sharedValues.animationInProgress = true
                        
//                        SwiftUI.withAnimation(sharedValues.animationOption == "slow" ? sharedValues.mySlowAnimation : sharedValues.animationOption == "fast" ? sharedValues.myFastAnimation : .none) {
//                            sharedValues.sliderProgress = CGFloat(newValue)
//                        }
                        
                        self.sharedValues.sliderProgress = CGFloat(newValue)
                        
                        
                        
//                        if imageSpiralViewModel.mode != sharedValues.mode {
//                            imageSpiralViewModel.changeMode(newMode: sharedValues.mode)
//                        }
                        
                        //sharedValues.oneTempleInfo.removeAll()
                        
                        self.sharedValues.singleTempleShow = false
                        
                        // we update spiral here,
                        // we call functions in imagespiral view mode to call functions in spiral mode, to change it
                        self.imageSpiralViewModel.getNewTheta(newTheta: self.sharedValues.sliderProgress)
                        self.imageSpiralViewModel.updateOnScreenTemples(newTheta: self.sharedValues.sliderProgress)
                    }
                    
//                    print("sharedValues.lastSliderProgress is \(sharedValues.lastSliderProgress)")
                    //print("sharedValues.sliderProgress is \(sharedValues.sliderProgress)")
//                    print("newValue is \(newValue)")

                    //print(imageSpiralViewModel.onScreenTemples.count)
                    
                }),
               in: 180...6980 + Double((sharedValues.numberOfTemples - 226) * 30), step: 1)
            //.background(Color.red)
        }
}
