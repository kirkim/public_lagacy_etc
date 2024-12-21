//
//  HomeVC.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var OpenMainViewBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OpenMainViewBtn.layer.cornerRadius = 20
    }
    
    @IBAction func handleOpenMainViewBtn(_ sender: UIButton) {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") else { return }
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
        
    }
}
