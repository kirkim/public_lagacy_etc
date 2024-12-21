//
//  ViewController.swift
//  Test_1_11
//
//  Created by 김기림 on 2022/01/11.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var myWebView: WKWebView!    
    @objc func loadWebView(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        myWebView.load(URLRequest(url: url))
    }
    
    @IBAction func openWebBtnBundlerView(_ sender: UIButton) {
        guard let openWebBundlerVC = self.storyboard?
                .instantiateViewController(withIdentifier: "WebButtonBundlerView")
                as? WebButtonBundlerView else { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadWebView),
                                               name: NSNotification.Name("openWebNotification"),
                                               object: nil)
        self.present(openWebBundlerVC, animated: true, completion: nil)
    }
    
    @IBAction func tempHandler(_ sender: Any) {
        guard let url = URL(string:  "https://kirkim.github.io") else { return }
        NotificationCenter.default.post(name: NSNotification.Name("openWebNotification"), object: url)
    }
    
    @IBAction func exitBtn(_ sender: UIButton) {
        if ((self.presentingViewController) != nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
