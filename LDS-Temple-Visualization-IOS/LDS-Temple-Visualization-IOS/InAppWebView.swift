//
//  InAppWebView.swift
//  LDS-Temple-Visualization-IOS
//
//  Created by tiantian on 2020/7/11.
//  Copyright © 2020 Litian Zhang. All rights reserved.
//

import SwiftUI

import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}

struct InAppWebView: View {
    
    @EnvironmentObject var settings: SettingValues
    
    var url: String
    
    var body: some View {
        WebView(request: URLRequest(url: URL(string: url)!))
    }
}

//struct InAppWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        InAppWebView()
//    }
//}