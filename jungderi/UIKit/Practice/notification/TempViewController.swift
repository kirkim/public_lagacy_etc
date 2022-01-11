//
//  TempView.swift
//  Test_1_11
//
//  Created by 김기림 on 2022/01/11.
//

import UIKit

class TempViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func openMainViewHandler(_ sender: UIButton) {
                guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else { fatalError() }
                self.present(mainVC, animated: true, completion: nil)
    }
}
