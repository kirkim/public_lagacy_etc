//
//  MainViewController.swift
//  NavigationViewC
//
//  Created by 김기림 on 2022/01/02.
//

import UIKit

class MainViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "메인화면"
        label.textColor = .white
        
        return label
    }()
    
    let changeBtn: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "배경색 바꾸기"
        configuration.image = UIImage(systemName: "bubble.left.fill")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 20, trailing: 5)
        configuration.baseForegroundColor = .red
        configuration.baseBackgroundColor = .black
        configuration.cornerStyle = .dynamic
        var btn = UIButton(configuration: configuration, primaryAction: .none)

        btn.addTarget(self, action: #selector(changeBg), for: .touchUpInside)
        return btn
    }()
    
    var isBgBrown: Bool = true
    
    @objc func changeBg() {
        view.backgroundColor = isBgBrown ? .blue : .brown
        
        self.isBgBrown.toggle()
    }
    
//    let sampleBtn: UIButton = {
//        var btn = UIButton(type: .system)
//        btn.setTitle("배경색 바꾸기", for: .normal)
//        btn.setTitleColor(.red, for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//        btn.backgroundColor = .black
//        btn.layer.cornerRadius = 5
//
//        return btn
//    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(changeBtn)
        
        changeBtn.translatesAutoresizingMaskIntoConstraints = false
        changeBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        changeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
