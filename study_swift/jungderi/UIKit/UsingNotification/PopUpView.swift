//
//  PopUpView.swift
//  UsingProtocol
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit

class PopUpView: UIViewController {
    @IBOutlet weak var githubBtn: UIButton!
    @IBOutlet weak var blogBtn: UIButton!
    @IBOutlet weak var naverBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 20
        githubBtn.myCustomBtn()
        blogBtn.myCustomBtn()
        naverBtn.myCustomBtn()
    }
    
    @IBAction func openNaver(_ sender: UIButton) {
        print("PopUpview - openNaver() - called")
        let url = URL(string: "https://www.naver.com")!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification"), object:url)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMyGithub(_ sender: UIButton) {
        print("PopUpview - openMyGithub() - called")
        let url = URL(string: "https://github.com/kirkim")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification"), object: url)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMyBlog(_ sender: UIButton) {
        print("PopUpview - openMyBlog() - called")
        let url = URL(string: "https://kirkim.github.io")!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notification"), object: url)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissPopUpView(_ sender: UIButton) {
        print("PopUpview - dismissPopUpView() - called")
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIButton {
    func myCustomBtn() {
        self.layer.cornerRadius = 20
    }
}
