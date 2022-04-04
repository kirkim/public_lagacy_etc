//
//  LoginPageVC.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginPageVC: UIViewController {
    private let titleLabel = UILabel()
    private let basicLoginView = BasicLoginView()
    private let createButton = UIButton()
    private let loginUserModel = UserModel()
    private let disposeBag = DisposeBag()
    private let signUpViewModel = RxSignUpPageViewModel()
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        layout()
        attribute()
//        bind(LoginPageViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: LoginPageViewModel) {
        self.basicLoginView.bind(viewModel.basicLoginViewModel)
    }
    
    private func attribute() {
        self.view.backgroundColor = .white
        KeyboardAnimation.dismissKeyboardBytouchBackground(view: self.view)
        
        titleLabel.text = "로그인"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        createButton.setTitle(" 회원가입 → ", for: .normal)
        createButton.setTitleColor(.brown, for: .normal)
        createButton.clipsToBounds = true
        createButton.layer.cornerRadius = 5
    }
    
    private func layout() {
        [titleLabel, basicLoginView, createButton].forEach {
            self.view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        basicLoginView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        createButton.snp.makeConstraints {
            $0.top.equalTo(basicLoginView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
        
    private func handleCreateUserButton() {
        let signUpVC = RxSignUpPageVC()
        signUpVC.bind(signUpViewModel)
        self.present(signUpVC, animated: true, completion: nil)
    }
}
