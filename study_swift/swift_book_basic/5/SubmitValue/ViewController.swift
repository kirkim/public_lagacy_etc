//
//  ViewController.swift
//  SubmitValue
//
//  Created by 김기림 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    @IBOutlet var isUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    // 자동 갱신 여부가 바뀔 때마다 호출되는 메소드
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    
    // 갱신주기가 바뀔 때마다 호출되는 메소드
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    
//    @IBAction func onSubmit(_ sender: Any) {
//        // VC2의 인스턴스 생성
//        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
//            return
//        }
//
//        // 값 전달
//        guard let text = self.email.text else {
//            return
//        }
//        rvc.paramEmail = text// 이메일
//        rvc.paramUpdate = self.isUpdate.isOn // 자동갱신 여부
//        rvc.paramInterval = self.interval.value // 갱신주기
//
//        // 화면 이동
//        self.navigationController?.pushViewController(rvc, animated: true)
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else {
            return
        }
        
         //값 전달
        guard let text = self.email.text else {
            return
        }
        rvc.paramEmail = text// 이메일
        rvc.paramUpdate = self.isUpdate.isOn // 자동갱신 여부
        rvc.paramInterval = self.interval.value // 갱신주기
    }
}

