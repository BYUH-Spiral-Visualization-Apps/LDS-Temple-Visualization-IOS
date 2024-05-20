//
//  SearchView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/9/5.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI


struct SearchView: View {
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var templeNames: Array<String> = ImageSpiral.templeNamesAndYears[0]
    var templeImageNames: Array<String> = ImageSpiral.templeNames
    
    @ObservedObject var imageSpiralViewModel: ImageSpiral
    
    @State private var searchText : String = ""
    
 
    
    var body: some View {
        
        VStack {
            Spacer(minLength: 20)
            
            HStack {
                Button(action: {
                    //self.self.sharedValues.showSelector.toggle()
                    //self.sharedValues.showYearPicker = false
                    SwiftUI.withAnimation(.default) {
                        self.sharedValues.showNameSearcher = false
                    }
                }) {
                    Text("back")
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    self.self.sharedValues.showSelector.toggle()
                    self.sharedValues.selectorSet = true
                    self.sharedValues.selectedTemple = self.searchText
                    //let newThetaFromYearPicker: CGFloat = self.templeNames.firstIndex(of: self.searchText)
                    let test: Int = self.templeNames.firstIndex(of: self.searchText) ?? 0
                    var newThetaFromSelector: CGFloat = 0
                    newThetaFromSelector = (self.sharedValues.mode == "default" ? (CGFloat)(test * 30 + 190) : (CGFloat)(test * 30 + 250))
                    
                    self.self.sharedValues.sliderProgress = newThetaFromSelector
                    self.self.imageSpiralViewModel.getNewTheta(newTheta: newThetaFromSelector)
                    self.self.imageSpiralViewModel.updateOnScreenTemples(newTheta: newThetaFromSelector)
                    self.sharedValues.templeNameSet = true
                    
                    
                }) {
                    Text("view")
                }
                .padding()
                .disabled(templeNames.contains(searchText) ? false : true)
                
                
            }
            
            TextField("type.in.here.to.search.a.temple", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
   
            
            
            List {
                ForEach(self.templeNames.filter {
                    self.searchText.isEmpty ? true : $0.contains(self.searchText)
                }, id: \.self) { name in
                    
                    Button(action: {
                        self.searchText = name
                    }) {
                        HStack {
                            Text(name)
                        }
                        
                    }

                }
            }
            
            
            .padding()
            
            Spacer()
        
        
        }
    
        
        
    }
}

