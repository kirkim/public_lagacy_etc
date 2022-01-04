//
//  MessageVC.swift
//  NavigationItem_NoStoryBoard
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit

class MessageVC: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지 화면"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
