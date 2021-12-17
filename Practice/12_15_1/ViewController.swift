//
//  ViewController.swift
//  12_15_1
//
//  Created by 김기림 on 2021/12/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aaaa: UILabel!
    var presentParam: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .system, primaryAction: UIAction(handler: openNewView))
        btn.setTitle("클릭", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.backgroundColor = .blue
        
        self.view.addSubview(btn)
//        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        btn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
//        btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        let btn2 = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50), primaryAction: UIAction(handler: { (sender) in
            let vc = ViewController2()
            vc.label1?.text = "바꼈다"
            vc.sample = "바꼈다"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        btn2.backgroundColor = .black
        btn2.setTitle("클릭", for: .normal)
        btn2.tintColor = .white
        self.view.addSubview(btn2)
    }
    
    func openNewView(_ sender: Any) {
        let sampleView = Sapmle()
        print(sampleView)
        self.present(sampleView, animated: true)
    }
}

