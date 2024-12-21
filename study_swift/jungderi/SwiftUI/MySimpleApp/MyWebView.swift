//
//  MyWebView.swift
//  practice12_21
//
//  Created by 김기림 on 2021/12/23.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    private var url: String
    
    init(url: String) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
}
