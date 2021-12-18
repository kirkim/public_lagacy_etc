//
//  WebView.swift
//  basic
//
//  Created by 김기림 on 2021/12/18.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> some UIView {
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        
        let wkWebView = WKWebView()
        wkWebView.load(request)
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

// UIViewController
struct MyWebVC: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let webVC = UIStoryboard(name: "WebViewController", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        // 네비게이션으로 감싼 웹뷰로 만들어줄 수 있음, 제목이나 다른 커스텀 아이템 사용가능해짐
        let navi = UINavigationController(rootViewController: webVC)
        
        return navi
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
