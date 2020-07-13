//
//  YearDisplayView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/13.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

struct YearDisplayView: View {
    
    //@ObservedObject var imageSpiralViewModel: ImageSpiral
    
    var startYear: String
    var endYear: String
    
    var body: some View {
        
        Text(startYear == "ere" ? "Announced Temples" :
                endYear == "1836" ? "Move Slider to View Temples" :
                endYear != "ere" ? "Temple Years: \(startYear) --- \(endYear)" :
                "Temple Years: \(startYear) --- 2020")
            
            
            .frame(width: screenWidth, height: screenHeight * 0.05, alignment: Alignment.center)
            //.background(Color.blue)
        // we need this background color for testing purposes
        
    }
}

//struct YearDisplayView_Previews: PreviewProvider {
//    static var previews: some View {
//        YearDisplayView()
//    }
//}
