//
//  Storyboard.swift
//  PresentView
//
//  Created by 김기림 on 2022/01/04.
//

import UIKit
import WebKit


class Storyboard: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentBtn: UIButton!
    var openMyBlogPageClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.cornerRadius = 20
        self.contentBtn.layer.cornerRadius = 20
    }
    
    @IBAction func dissMissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openBlog(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        // 컴플레션 블럭 호출
        if let openMyBlogPageClosure = openMyBlogPageClosure {
            // 메인에 알린다.
            openMyBlogPageClosure()
        }
    }
}
