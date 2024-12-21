//
//  CustomButton.swift
//  Practice_customButton
//
//  Created by 김기림 on 2022/02/02.
//

import UIKit

enum Direction {
    case top
    case right
    case bottom
    case left
}

class CustomButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    private func configure() {
        self.addTarget(self, action: #selector(customAction), for: .touchUpInside)
    }
    
    @objc func customAction(_ sender: UIButton) {
    }
}

class RotationButton: CustomButton {
    var completionDirection: (Direction?) -> Void = { _ in }
    
    private var direction: Direction? = .top {
        didSet {
            transformButton()
        }
    }
    
    override func customAction(_ sender: UIButton) {
        switch self.direction {
        case .top:
            self.direction = .right
        case .right:
            self.direction = .bottom
        case .bottom:
            self.direction = .left
        case .left:
            self.direction = .top
        default:
            self.direction = .right
        }
        completionDirection(self.direction)
    }
    
    private func transformButton() {
        switch self.direction {
        case .right:
            self.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        case .bottom:
            self.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        case .left:
            self.titleLabel?.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 3) / 2)
        case .top:
            self.titleLabel?.transform = .identity
        default:
            self.titleLabel?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.bounds.height, height: self.bounds.width)
    }
}
