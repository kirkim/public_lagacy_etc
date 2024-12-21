//
//  ViewController.swift
//  PanGesture_App
//
//  Created by 김기림 on 2021/12/12.
//

import UIKit

enum DragType {
    case x
    case y
    case none
}


class ViewController: UIViewController {

    var dragType = DragType.none
    let myView = DragAbleView()
    @IBOutlet weak var selectBar: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let baseView = UIView()
//        baseView.frame = CGRect(x: 0, y: self.selectBar.frame.maxY + 5, width: self.view.frame.width, height: self.view.frame.height - (self.selectBar.frame.maxY + 5))
//
//        myView.center = baseView.center
//        myView.bounds = CGRect(x: 0,  y: 0, width: 100, height: 100)
//        myView.dragType = .x
//        myView.backgroundColor = .red
//
//        baseView.addSubview(myView)
//        self.view.addSubview(baseView)
        
        
    }
    
    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            dragType = .x
        case 1:
            dragType = .y
        case 2:
            dragType = .none
        default:
            break
        }
        
        myView.dragType = self.dragType
    }
    

}

