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
    var myPopUpDelegate: PopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        githubBtn.myCustomBtn()
        blogBtn.myCustomBtn()
    }
    
    @IBAction func openMyGithub(_ sender: UIButton) {
        print("PopUpview - openMyGithub() - called")
        let url = URL(string: "https://github.com/kirkim")!
        myPopUpDelegate?.openWebPage(url: url)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openMyBlog(_ sender: UIButton) {
        print("PopUpview - openMyBlog() - called")
        let url = URL(string: "https://kirkim.github.io")!
        myPopUpDelegate?.openWebPage(url: url)
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
