//
//  ViewController.swift
//  NiceApp
//
//  Created by 김기림 on 2022/01/02.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "메인화면"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    let animationView: AnimationView = {
        let animView = AnimationView(name: "newYear")
        animView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        animView.contentMode = .scaleAspectFit
        return animView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(animationView)
        animationView.center = view.center
        
        // 애니메이션 실행
        animationView.play { finish in
            print("애니메이션이 끝났다.")
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview() // 현재 animationView 부모뷰는 View
            
            self.view.addSubview(self.titleLabel)
            
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
}

