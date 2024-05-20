//
//  SelectorsView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/9/5.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct SelectorsView: View {
    

    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
        
    @EnvironmentObject var sharedValues: SharedValues
    
    var body: some View {

        VStack {
            if !sharedValues.showYearPicker && !sharedValues.showNameSearcher {
                SelectorsViewPre()
            } else if sharedValues.showYearPicker {
                YearPicker(imageSpiralViewModel: self.imageSpiralViewModel)
            } else if sharedValues.showNameSearcher {
                SearchView(imageSpiralViewModel: self.imageSpiralViewModel)
            }
            
        }
        
        

        
    }
}

struct SelectorsViewPre: View {
        
    @EnvironmentObject var sharedValues: SharedValues
    

    var body: some View {
                
        VStack {
        
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray)
                    .padding()
                VStack {
                    Text("pick.a.year")
                    Image(systemName: "calendar")
                }
                
            }
            .onTapGesture {
                SwiftUI.withAnimation(.default) {
                    self.sharedValues.showYearPicker = true
                }
                
                
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray)
                    .padding()
                VStack {
                    Text("search.by.name")
                    Image(systemName: "textbox")
                }
                
            }.onTapGesture {
                SwiftUI.withAnimation(.default) {
                    self.sharedValues.showNameSearcher = true
                }
                
            }
            
            Button(action: {
                self.sharedValues.showSelector.toggle()
            }) {
                Text("dismiss")
            }
            .padding()
            
            Spacer()

                
        }
    }

}

