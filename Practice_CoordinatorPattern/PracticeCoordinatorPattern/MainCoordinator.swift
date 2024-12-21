//
//  MainCoordinator.swift
//  PracticeCoordinatorPattern
//
//  Created by 김기림 on 2022/09/14.
//

import UIKit

final class MainCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        
        navigationController.delegate = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func secondSubscriptions() {
        let child = SecondCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // 이동 전 ViewController
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // fromViewController가 navigationController의 viewControllers에 포함되어있으면 return. 왜냐하면 여기에 포함되어있지 않아야 현재 fromViewController 가 사라질 화면을 의미.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // child coordinator 가 일을 끝냈다고 알림.
        if let secondVC = fromViewController as? SecondViewController {
            childDidFinish(secondVC.coordinator)
        }
    }
}
