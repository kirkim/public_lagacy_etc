//
//  MainVC.swift
//  PracticeAVFoundation
//
//  Created by 김기림 on 2022/02/08.
//

import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Player", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "PlayerVC")
        self.tabBarController?.addChild(VC)
        
    }
}
