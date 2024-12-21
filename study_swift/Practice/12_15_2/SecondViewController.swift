//
//  SecondViewController.swift
//  12_15_2
//
//  Created by 김기림 on 2021/12/15.
//
//    let codeLabel = UILabel()
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var storyLabel: UILabel!
    var codeLabel: UILabel?
    var classLevelCodeLabel = UILabel()

    override func viewDidLoad() {
        codeLabel = UILabel()
//        codeLabel?.text = "코드 Label"
        self.view.addSubview(codeLabel!)
//        classLevelCodeLabel.text = "클래스코드 Label"
        self.view.addSubview(classLevelCodeLabel)
        
        customLabels()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 단순히 코드Label을 꾸며주기위해 만든 함수
    func customLabels() {
        codeLabel?.frame = CGRect(x: 0, y: 350, width: self.view.frame.width, height: 40)
        codeLabel?.backgroundColor = .black
        codeLabel?.textAlignment = .center
        codeLabel?.textColor = .white
        classLevelCodeLabel.frame = CGRect(x: 0, y: 400, width: self.view.frame.width, height: 40)
        classLevelCodeLabel.backgroundColor = .black
        classLevelCodeLabel.textAlignment = .center
        classLevelCodeLabel.textColor = .white
    }
}
