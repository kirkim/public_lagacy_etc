//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 김기림 on 2021/11/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 텍스트 필드 속성 설정
        self.tf.placeholder = "값을 입력하세요"
        self.tf.keyboardType = UIKeyboardType.alphabet
        //self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.keyboardAppearance = .dark // 키보드 스타일 어둡게
        self.tf.returnKeyType = UIReturnKeyType.join // 리턴키 타입은 "Join"
        self.tf.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 "On" -> 텍스트에 글이 없으면 리턴키를 비활성화 시킴
        
        /**
         * 스타일 설정
         */
        // 테두리 스타일 - 직선
        self.tf.borderStyle = UITextField.BorderStyle.line
        
        // 배경 색상
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0)
        
        // 수직 방향으로 텍스트가 가운데 정렬되도록
        self.tf.contentVerticalAlignment = .center
        
        // 수평 방향으로 텍스트가 가운데 정렬되도록
        self.tf.contentHorizontalAlignment = .center
        
        // 테두리 색상을 회색으로
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        
        // 테두리 두께 설정 (단위: pt)
        self.tf.layer.borderWidth = 2.0
        
        // 텍스트 필드를 최초 응답자로 지정
        self.tf.becomeFirstResponder()
        
        
        // 델리게이트 지정
        self.tf.delegate = self
    }
    
    @IBAction func confirm(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체로 지정
        self.tf.becomeFirstResponder()
    }
    
    
    
    // UITextFieldDelegate
    // 텍스트필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        return true // false를 리턴하면 편집되지 않는다.
    }
    
    // 텍스트 필드의 편집이 시작된 후 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 시작되었습니다.")
    }
    
    // 텍스트 필드의 내용이 삭제될 때 호출
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됩니다")
        return true // false를 리턴하면 삭제되지 않는다.
    }
    
    // 텍스트 필드의 내용이 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됩니다")
        if Int(string) == nil { // 입력된 값이 숫자가 아니라면 true를 리턴
            // 현재 텍스트 필드에 입력된 길이와 더해질 문자열 길이의 합이 10으 넘는다면 반영하지 않음
            if (textField.text?.count)! + string.count > 10 {
                return false
            } else {
                return true
            }
        } else { // 입력된 값이 숫자라면 false를 리턴
            return false
        }
    }
    
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다")
        return true
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다.")
        return true // false를 리턴하면 편집이 종료되지 않는다.
    }
    
    // 텍스트 필드의 편집이 종료되었을 때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 종료되었습니다.")
    }
}

