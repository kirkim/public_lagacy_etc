//
//  WebViewController.swift
//  basic
//
//  Created by 김기림 on 2021/12/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "iPhoneInfo") // 이름을 찾아서 수신
        contentController.add(self, name: "aaa") // 이름을 찾아서 수신
        contentController.add(self, name: "bbb") // 이름을 찾아서 수신
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.view.addSubview(webView)
        
        let localFile = Bundle.main.path(forResource: "TestWeb", ofType: "html")
        let url = URL(fileURLWithPath: localFile!)
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "iPhoneInfo" {
            print(message.body) // web에서 보낸내용 확인가능
            print("call native")
        }
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "js test", message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("showAlert('hi')", completionHandler: nil)
    }
}
