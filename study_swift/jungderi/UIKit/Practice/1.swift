//
//  ViewController.swift
//  awesomeSwift_Practice
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit
import PKHUD

typealias TempType = (String) -> ()

class ViewController: UIViewController {
    
    var isHello: Bool = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "호출전"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .green
        
        return label
    }()

    let callFuncBtn: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.titlePadding = 30
        
        let btn = UIButton(configuration: configuration, primaryAction: nil)
        btn.backgroundColor = .black
        btn.setTitle("callHelloFunc", for: .normal)
        btn.layer.cornerRadius = 10
        btn.setTitleColor(.yellow, for: .normal)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(callFuncBtn)
        
        callFuncBtn.translatesAutoresizingMaskIntoConstraints = false
        callFuncBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callFuncBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        callFuncBtn.addTarget(self, action: #selector(tempFunc), for: .touchUpInside)
    }
    
    @objc func tempFunc() {
        HUD.show(.progress)
        sayHello_After_2sec(completion: { result in
            print(result)
        })
    }

    func sayHello_After_2sec(completion: @escaping TempType) {
        print("함수가 호출되어 처리중입니다.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("결과")
            self.titleLabel.text = self.isHello ? "GoodBye" : "Hello!"
            self.isHello.toggle()
            HUD.flash(.success, delay: 1.0)
        }
    }
}

