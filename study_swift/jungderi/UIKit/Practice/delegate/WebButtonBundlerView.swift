//
//  WebButtonBundlerView.swift
//  Test_1_11
//
//  Created by 김기림 on 2022/01/11.
//

import UIKit

class WebButtonBundlerView: UIViewController {
    var myOpenWebDelegate: OpenWebDelegate?
    
    func setUrlAndDismiss(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        myOpenWebDelegate?.openWebPage(url: url)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleOpenGoogleBtn(_ sender: UIButton) {
        setUrlAndDismiss("https://www.google.co.kr")
    }
    
    @IBAction func handleOpenNaverBtn(_ sender: UIButton) {
        setUrlAndDismiss("https://www.naver.com")
    }
    
    @IBAction func handleOpenDaumBtn(_ sender: UIButton) {
        setUrlAndDismiss("https://www.daum.net")
    }
}
