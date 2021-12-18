//
//  ViewController.swift
//  WebViewController
//
//  Created by 김기림 on 2021/12/19.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start!")
        let contentController = WKUserContentController()
        contentController.add(self, name: "iPhoneInfo")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        
        self.view.addSubview(webView)
        
        let localFile = Bundle.main.path(forResource: "TestWeb", ofType: "html")
        let url = URL(fileURLWithPath: localFile!)
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "iPhoneInfo" {
            print("call native")
        }
    }
}
