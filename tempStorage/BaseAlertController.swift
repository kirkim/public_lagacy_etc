//
//  BaseAlertController.swift
//  AniFace
//
//  Created by 김기림 on 2022/10/05.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class BasicAlertViewController: UIViewController {
    
    private lazy var alertStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.becomeFirstResponder()
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()
    
    private lazy var buttonHorizonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 입력 ", for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 취소 ", for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureAttribute()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.map({ $0.view }).contains(alertStackView) == false {
            dismiss(animated: true)
        }
    }
    
    deinit {
        print("deinit!")
    }
}

//MARK: - Attribute, Layout 메서드
extension BasicAlertViewController {
  
  private func configureAttribute() {
    //temp
    textView.backgroundColor = .purple
    alertStackView.backgroundColor = .gray
    
    view.backgroundColor = .white.withAlphaComponent(0.3)
  }
  
  private func configureLayout() {
    [okButton, cancelButton].forEach {
      buttonHorizonStackView.addArrangedSubview($0)
    }
    
    [UIView(), textView, buttonHorizonStackView].forEach {
      alertStackView.addArrangedSubview($0)
    }
    
    view.addSubview(alertStackView)
    
    alertStackView.snp.makeConstraints {
      $0.width.equalTo(UIScreen.main.bounds.width * 0.8)
      $0.height.equalTo(UIScreen.main.bounds.height * 0.3)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(-100)
    }
    
    textView.snp.makeConstraints {
      $0.width.equalTo(alertStackView).multipliedBy(0.9)
      $0.height.equalTo(alertStackView).multipliedBy(0.3)
    }
    
    buttonHorizonStackView.snp.makeConstraints {
      $0.width.equalTo(alertStackView)
    }
  }
}

extension Reactive where Base: BasicAlertViewController {
  var tappedOkButton: ControlEvent<Void> {
    return base.okButton.rx.tap
  }
}
