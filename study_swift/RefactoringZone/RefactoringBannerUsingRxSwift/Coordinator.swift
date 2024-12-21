//
//  coordinator.swift
//  RefactoringBannerUsingRxSwift
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit

class Coordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootVC = TestBannerVC()
        let rootNavigationController = UINavigationController(rootViewController: rootVC)
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
}
