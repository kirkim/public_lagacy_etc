//
//  SecondCoordinator.swift
//  PracticeCoordinatorPattern
//
//  Created by 김기림 on 2022/09/14.
//

import UIKit

final class SecondCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinishSecond() {
        parentCoordinator?.childDidFinish(self)
    }
}
