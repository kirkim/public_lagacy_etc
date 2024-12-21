//
//  WebButtonBundlerView.swift
//  Test_1_11
//
//  Created by 김기림 on 2022/01/11.
//

import UIKit

enum MyError: Error {
    case error(message: String)
}

class WebButtonBundlerView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func postUrlNotification(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        NotificationCenter.default.post(name: NSNotification.Name("openWebNotification"), object: url)
//        guard let presentedVC = self.presentingViewController as? MainViewController else {
//            fatalError()
//        }
//        NotificationCenter.default.removeObserver(presentedVC, name: NSNotification.Name("openWebNotification"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleOpenGoogleBtn(_ sender: UIButton) {
        postUrlNotification("https://www.google.co.kr")
    }
    @IBAction func handleOpenNaverBtn(_ sender: UIButton) {
        postUrlNotification("https://www.naver.com")
    }
    @IBAction func handleOpenDaumBtn(_ sender: UIButton) {
        postUrlNotification("https://www.daum.net")
    }
}
