//
//  SettingView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/10.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var body: some View {
        SettingViewMain(imageSpiralViewModel: imageSpiralViewModel)
            .navigationBarTitle("settings")
    }
}

struct SettingViewMain: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    @ObservedObject var imageSpiralViewModel: ImageSpiral
  
    var body: some View {
        return HStack {
                VStack {
                    HStack {
                        SpiralEffectSettingButton(imageSpiralViewModel: imageSpiralViewModel)
                        AnimationSettingButton()
                    }
                    HStack {
                        LabelSettingButton()
                        VStack {
                            //TempleListButton()
                            AboutButton()
                        }
                    }
                }
        }
    }
    }

struct SpiralEffectSettingButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sharedValues: SharedValues
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(sharedValues.nonMainViewColorSchema)
            VStack {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.defaultColor)
                        Text("default")
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            //sharedValues.mode = "default"
                            self.imageSpiralViewModel.changeMode(newMode: "default")
                            self.sharedValues.defaultColor = self.sharedValues.selectedColor
                            self.sharedValues.spinColor = self.sharedValues.unSelectedColor
                            self.sharedValues.threeDColor = self.sharedValues.unSelectedColor
                            self.sharedValues.mode = "default"
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.spinColor)
                        Text("spin")
                        
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            //sharedValues.mode = "spin"
                            self.imageSpiralViewModel.changeMode(newMode: "spin")
                            self.sharedValues.defaultColor = self.sharedValues.unSelectedColor
                            self.sharedValues.spinColor = self.sharedValues.selectedColor
                            self.sharedValues.threeDColor = self.sharedValues.unSelectedColor
                            self.sharedValues.mode = "spin"
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(sharedValues.threeDColor)
                        Text("3d")
                    }
                    .onTapGesture {
                        SwiftUI.withAnimation(.linear) {
                            //sharedValues.mode = "3D"
                            self.imageSpiralViewModel.changeMode(newMode: "3D")
                            self.sharedValues.defaultColor = self.sharedValues.unSelectedColor
                            self.sharedValues.spinColor = self.sharedValues.unSelectedColor
                            self.sharedValues.threeDColor = self.sharedValues.selectedColor
                            self.sharedValues.mode = "3D"
                        }
                    }
                    
                    Text("mode")
                        .padding()
                        .font(.headline)
                }
            }
        }
    }
}

struct AnimationSettingButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(sharedValues.nonMainViewColorSchema)
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.slowAnimationColor)
                    Text("slow")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        self.sharedValues.animationOption = "slow"
                        self.sharedValues.slowAnimationColor = self.sharedValues.selectedColor
                        self.sharedValues.fastAnimationColor = self.sharedValues.unSelectedColor
                        self.sharedValues.offAnimationColor = self.sharedValues.unSelectedColor
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.fastAnimationColor)
                    Text("fast")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        self.sharedValues.animationOption = "fast"
                        self.sharedValues.slowAnimationColor = self.sharedValues.unSelectedColor
                        self.sharedValues.fastAnimationColor = self.sharedValues.selectedColor
                        self.sharedValues.offAnimationColor = self.sharedValues.unSelectedColor
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.offAnimationColor)
                    Text("off")
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        self.sharedValues.animationOption = "off"
                        self.sharedValues.slowAnimationColor = self.sharedValues.unSelectedColor
                        self.sharedValues.fastAnimationColor = self.sharedValues.unSelectedColor
                        self.sharedValues.offAnimationColor = self.sharedValues.selectedColor
                    }
                }
                
                Text("animation")
                    .padding()
                    .font(.headline)
            }
            //.background(Color.gray)
        }
    }
}

struct LabelSettingButton: View {
        
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
//        HStack {
//            if sharedValues.showLabelBackgroundOption {
//                LabelBackGroundSettingButton()
//            } else {
//                LabelSettingOnOffButton()
//            }
//        }
        
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(sharedValues.nonMainViewColorSchema)
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelOn)
                    VStack {
                        Text("on")
                        
//                        if sharedValues.showLabelBackground {
//                            Text("with.background").font(.system(size: 10))
//                        } else {
//                            Text("without.background").font(.system(size: 10))
//                        }
                        // cannot use this, because string wont localize
                        //Text(sharedValues.showLabelBackground ?  : "without background")
                            
                            
                    }
                    
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        self.sharedValues.showLabel = true
                        self.sharedValues.showLabelOn = self.sharedValues.selectedColor
                        self.sharedValues.showLabelOff = self.sharedValues.unSelectedColor
                        //sharedValues.showLabelBackgroundOption.toggle()
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(sharedValues.showLabelOff)
                    Text("off")
                        
                }
                .onTapGesture {
                    SwiftUI.withAnimation(.linear) {
                        self.sharedValues.showLabel = false
                        self.sharedValues.showLabelOn = self.sharedValues.unSelectedColor
                        self.sharedValues.showLabelOff = self.sharedValues.selectedColor
                    }
                }
                
                Text("label")
                    .padding()
                    .font(.headline)
            }
            //.background(Color.gray)
        }
        
        
    }
    
}
struct AboutButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {
        
        NavigationLink(destination: AboutView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(sharedValues.nonMainViewColorSchema)
                
                Text("about")
                    .padding()
                    // check system is in dark or light mode then use different color 
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

struct TempleListButton: View {
    @EnvironmentObject var sharedValues: SharedValues
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationLink(destination: InAppWebView(url: sharedValues.templesList)) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(sharedValues.nonMainViewColorSchema)
                HStack {
                    Text("temple.list")
                    Image(systemName: "link")
                }
                    .padding()
                    // check system is in dark or light mode then use different color
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
    }
}

