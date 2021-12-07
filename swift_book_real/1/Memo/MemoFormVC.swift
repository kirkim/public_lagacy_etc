//
//  MemoFormVC.swift
//  Memo
//
//  Created by 김기림 on 2021/12/01.
//

import UIKit

class MemoFormVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 🤡경고창에 사용될 콘텐츠 뷰 컨트롤러 구성
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        // (1) 내용을 입력하지 않을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            // 콘텐츠 뷰 영역에 alertV🤡를 등록한다.
            alert.setValue(alertV, forKey: "contentViewController")
            self.present(alert, animated: true)
            return
        }
        
        // (2) MemoData 객체를 생성하고, 데이터를 담는다
        let data = MemoData()
        
        data.title = self.subject // 제목
        data.contents = self.contents.text // 내용
        data.image = self.preview.image // 이미지
        data.regdate = Date() // 작성 시각
        
        // (3) 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // (4) 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
    }
    
    // 사용자가 이미지를 선택하면 자동으로 이 메소드가 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 출력한다.
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        self.contents.delegate = self
        
        // 배경 이미지 설정
        let bgImage = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        // 텍스트 뷰의 기본 속성
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        // 줄 간격
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string:" ", attributes: [.paragraphStyle: style])
        self.contents.text = ""
    }
    
    // 사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출된다.
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length) )
        
        // 내비게이션 타이틀에 표시한다.
        self.navigationItem.title = self.subject
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            bar?.alpha = ( bar?.alpha == 0 ? 1 : 0)
        }
    }
}
