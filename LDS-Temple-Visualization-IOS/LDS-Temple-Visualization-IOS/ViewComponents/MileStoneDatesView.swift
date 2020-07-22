//
//  MileStoneDatesView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct MileStoneDatesView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var oneTempleInfo: String {
        get {
            
            var s: String = " "
            for i in sharedValues.oneTempleInfo {
                s += i.content
            }
            return s
        }
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: InAppWebView(url: sharedValues.currentTappedTempleLink)) {
                HStack {
                    Text(sharedValues.currentTappedTempleName)
                    Image(systemName: "link")
                }
            }
            ScrollView {
                VStack {
                    Text(oneTempleInfo)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .onTapGesture {
            SwiftUI.withAnimation(sharedValues.hasAnimation ? sharedValues.mySlowAnimation : sharedValues.myFastAnimation) {
                // when we tap mile stone dates in single temple view, we will bring slider back and makk mile stone dates disappear
                sharedValues.tappedATemple = false
            }
        }
    }
}


//struct MileStoneDatesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MileStoneDatesView()
//    }
//}
