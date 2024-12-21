//
//  ViewController.swift
//  Test_1_11
//
//  Created by 김기림 on 2022/01/11.
//

import UIKit
import WebKit

class ViewController: UIViewController, OpenWebDelegate {
    
    @IBOutlet weak var myWebView: WKWebView!
    
    @IBAction func openWebBtnBundlerView(_ sender: UIButton) {
        guard let openWebBundlerVC = self.storyboard?
                .instantiateViewController(withIdentifier: "WebButtonBundlerView")
                as? WebButtonBundlerView else { return }
        openWebBundlerVC.myOpenWebDelegate = self // delegate를 이곳에서 처리
        self.present(openWebBundlerVC, animated: true, completion: nil)
    }
    
    /* OpenWebDelegate 내장함수를 구현 */
    func openWebPage(url: URL) {
        myWebView.load(URLRequest(url: url))
    }
    @IBAction func handleTempBtn(_ sender: UIButton) {
        guard let openWebBundlerVC = self.storyboard?
                .instantiateViewController(withIdentifier: "TempViewController")
                as? TempViewController else { return }
        openWebBundlerVC.myOpenWebDelegate = self // delegate를 이곳에서 처리
        self.present(openWebBundlerVC, animated: true, completion: nil)
    }
}
