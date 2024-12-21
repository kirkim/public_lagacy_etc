//
//  Coordinator.swift
//  PracticeCoordinatorPattern
//
//  Created by 김기림 on 2022/09/14.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
