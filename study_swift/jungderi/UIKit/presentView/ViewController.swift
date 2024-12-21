//
//  ViewController.swift
//  PresentView
//
//  Created by 김기림 on 2022/01/04.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popupViewBtn(_ sender: Any) {
        let popStoryboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let popVC = popStoryboard.instantiateViewController(withIdentifier: "Storyboard") as! Storyboard

        popVC.modalPresentationStyle = .overCurrentContext
        popVC.modalTransitionStyle = .crossDissolve
        
        popVC.openMyBlogPageClosure = {
            print("컴플레션 블럭이 호출되었다.")
            let url = URL(string: "https://kirkim.github.io")!
            self.myWebView.load(URLRequest(url: url))
        }
        
        self.present(popVC, animated: true, completion: nil)
    }
}
