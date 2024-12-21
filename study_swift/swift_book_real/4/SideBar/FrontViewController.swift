//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by 김기림 on 2021/12/07.
//

import UIKit
class FrontViewController : UIViewController {
    
    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 메인 컨트롤러의 참조 정보를 가져온다.
        // 이 버튼은 일반 버튼이 아니라 BarButtonItem객체이기 때문에, addTarget(_:action:for:)메소드를 사용할 수 없다.
        // 그렇기 때문에 아래처럼 target과 action을 직접 넣어줘야함
        // 다만 이벤트종류는 지정해줄 필요가없는데 BarButtonItem객체가 TouchUpInside 이벤트 한 가지만 발생시키기 때문
        if let revealVC = self.revealViewController() {
            // 버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle(_:)을 호출하도록 정의한다.
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            // 제스처를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
