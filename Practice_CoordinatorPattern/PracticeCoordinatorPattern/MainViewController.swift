//
//  MainViewController.swift
//  PracticeCoordinatorPattern
//
//  Created by 김기림 on 2022/09/14.
//

import UIKit

class MainViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private lazy var pushButton:UIButton = {
        let button = UIButton()
        button.setTitle("PUSH", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 35, weight: .medium)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureLayout()
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handlePushButton(_ sender: UIButton) {
        coordinator?.secondSubscriptions()
    }
    
    private func configureAttribute() {
        view.backgroundColor = .blue
        pushButton.addTarget(self, action: #selector(handlePushButton), for: .touchUpInside)
    }
    
    private func configureLayout() {
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

