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
    
    @EnvironmentObject var sharedValues: SharedValues
    
    var url: String
    
    var body: some View {
        VStack {
            // if the passed in text is no link, we will just display a message, instead of a webview 
            if url == "no link" {
                Text("this.temple.does.not.have.a.website.yet") // we don't need this anymore, because we are showing a alert, see below
                Text("slide.right.to.return")
            } else {
                WebView(request: URLRequest(url: URL(string: url)!))
            }
        }
//        .alert(isPresented: $sharedValues.thisTempleHasNoLink) {
//                    Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
//                }
    }
}

//struct InAppWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        InAppWebView()
//    }
//}
