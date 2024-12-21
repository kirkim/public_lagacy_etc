//
//  ViewController.swift
//  UsingProtocol
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(loadWebView), name: NSNotification.Name(rawValue: "notification"), object: nil)
    }

    @objc func loadWebView(_ notification: Notification) {
        print("ViewController - loadWebView() - called")
        let url = notification.object as! URL
        myWebView.load(URLRequest(url: url))
    }

    @IBAction func openPopUpView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PopUpView", bundle: nil)
        guard let popUpVC = storyboard.instantiateViewController(withIdentifier: "PopUpView") as? PopUpView else {
            return
        }
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        self.present(popUpVC, animated: true, completion: nil)
    }
}
