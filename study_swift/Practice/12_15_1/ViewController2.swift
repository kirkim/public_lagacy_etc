//
//  ViewController2.swift
//  12_15_1
//
//  Created by 김기림 on 2021/12/15.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textField: UITextField!
    var sample: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentSubView()
        self.label2.text = sample
    }
    
    func presentSubView() {
        let button = UIButton()
        button.setTitle("input", for: .normal)
        //button.addAction(<#T##action: UIAction##UIAction#>, for: <#T##UIControl.Event#>)
        button.frame = CGRect(x: 100, y: 100, width:100, height: 50)
        button.backgroundColor = .green
        self.view.addSubview(button)
        button.addTarget(self, action:  #selector(inputData(_:)), for: .touchUpInside)
    }
    
    @objc func inputData(_ sender: Any) {
        guard let vc = self.presentingViewController as? ViewController else {
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
        guard let vc = self.presentingViewController as? ViewController else {
            return
        }
            
            vc.aaaa.text = "hello"
        }
    }

