//
//  SecondViewController.swift
//  PracticeCoordinatorPattern
//
//  Created by 김기림 on 2022/09/14.
//

import UIKit

final class SecondViewController: UIViewController {
    
    weak var coordinator: SecondCoordinator?

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
