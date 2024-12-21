//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by 김기림 on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
//    // 값을 직접 전달받을 프로퍼티들
//    var paramEmail: String?
//    var paramUpdate: Bool?
//    var paramInterval: Double?
//
//    // 화면이 표시될 때마다 실행되는 메소드
//    <방법 1>
//    override func viewWillAppear(_ animated: Bool) {
//        if let email = paramEmail {
//            resultEmail.text = email
//        }
//        if let update = paramUpdate {
//            resultUpdate.text = update == true ? "자동갱신" : "자동갱신안함"
//        }
//        if let interval = paramInterval {
//            resultInterval.text = "\(Int(interval))분마다"
//        }
//    }
    
//    <방법 2>
//    override func viewWillAppear(_ animated: Bool) {
//
//        // AppDelegate 객체의 인스턴스를 가져온다.
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail { // 이메일 표시
//            resultEmail.text = email
//        }
//        if let update = ad?.paramUpdate { // 자동 갱신 여부 표시
//            resultUpdate.text = update==true ? "자동갱신":"자동갱신안함"
//        }
//        if let interval = ad?.paramInterval { // 갱신 주기 표시
//            resultInterval.text = "\(Int(interval))분마다"
//        }
//    }
    
// <방법 3>
    override func viewWillAppear(_ animated: Bool) {

        // UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") { // UserDefaults객체에서는 String타입의 메소드만 반환값이 옵셔널 타입임 적절히 해제가 필요
            resultEmail.text = email                // guard 구문을 사용하지 않고 if 구문을 사용한 것은 해당 값이 없더라도 메소드가 종료되어서는 안 되기 때문이다.
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update == true ? "자동갱신" : "자동갱신안함")

        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분마다"
    }
}
