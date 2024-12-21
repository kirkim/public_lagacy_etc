//
//  ViewController.swift
//  UsingProtocol
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit
import WebKit

class ViewController: UIViewController, PopUpDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func openPopUpView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PopUpView", bundle: nil)
        guard let popUpVC = storyboard.instantiateViewController(withIdentifier: "PopUpView") as? PopUpView else {
            return
        }
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.myPopUpDelegate = self
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    func openWebPage(url: URL) {
        self.myWebView.load(URLRequest(url: url))
    }
}

