//
//  ViewController.swift
//  passingData1
//
//  Created by 김기림 on 2021/12/08.
//

// 1. instance property
// 2. segue
// 3. instance
// 4. delegae (delegation) pattern 대리 위임 대신
// 5. closure
// 6. Notification



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openPage2(_ sender: Any) {
        let vc2 = ViewController2(nibName: "ViewController2", bundle: nil)
        vc2.param = "hello"
        self.present(vc2, animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePage3" {
            guard let vc = segue.destination as? ViewController3 else {
                return
            }
            vc.param = "wow!"
        } else if segue.identifier == "seguePage4" {
            guard let vc = segue.destination as? ViewController4 else {
                return
            }
            vc.MainView = self
        } else if segue.identifier == "seguePage6" {
            guard let vc = segue.destination as? ViewController6 else {
                return
            }
            vc.myClosure = { str in
                self.output.text = str
            }
        }
    }
    
    @IBAction func openPage5(_ sender: Any) {
        let vc = ViewController5(nibName: "ViewController5", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension ViewController : ViewController5Delegate {
    func pushData(data: String) {
        self.output.text = data
    }
}
