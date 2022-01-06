//
//  BaseVC.swift
//  UsingToastApi
//
//  Created by 김기림 on 2022/01/07.
//

import UIKit

class BaseVC: UIViewController {
    var vcTitle : String = "" {
        didSet {
            print("UserListVC - vcTitle didSet() called / vcTitle: \(vcTitle)")
            self.title = vcTitle
        }
    }
}
