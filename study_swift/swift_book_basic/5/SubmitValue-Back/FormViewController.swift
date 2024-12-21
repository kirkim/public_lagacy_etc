//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by 김기림 on 2021/11/24.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    // 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func onSubmit(_ sender: Any) {
//        <방법 1>
//        let preVC = self.presentingViewController
//        guard let vc = preVC as? ViewController else {
//            return
//        }
//
//        vc.paramEmail = self.email.text
//        vc.paramUpdate = self.isUpdate.isOn
//        vc.paramInterval = self.interval.value
        
//        <방법 2>
//        // AppDelegate이용: app종료시 삭제
//        // AppDelegate 객체의 인스턴스를 가져온다.
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        // 값을 저장한다
//        ad?.paramEmail = self.email.text
//        ad?.paramUpdate = self.isUpdate.isOn
//        ad?.paramInterval = self.interval.value
        
//        <방법 3>
        // UserDefault 객체의 인스턴트 이용: app삭제시 없어짐
        // UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        // 값을 저장한다.
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpdate.isOn, forKey: "isUpdate")
        ud.set(self.interval.value, forKey: "interval")
        
        // 이전 화면으로 복귀한다.
        self.presentingViewController?.dismiss(animated: true)
    }
}
