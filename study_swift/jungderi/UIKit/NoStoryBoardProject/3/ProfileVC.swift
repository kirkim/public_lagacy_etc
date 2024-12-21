//
//  ProfileVC.swift
//  NavigationItem_NoStoryBoard
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit

class ProfileVC: UIViewController {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "프로필 화면"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
