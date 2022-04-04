//
//  LoginButtonViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/04/01.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginButtonViewModel {
    let httpManager = RxUserHttpManager()
    let disposeBag = DisposeBag()
    
    //View -> ViewModel
    let buttonTapped = PublishRelay<Void>()
    
    //ViewModel -> View
    let isValidSignUp = PublishRelay<Bool>()
    let presentAlert = PublishRelay<String>()
    
    //ParentViewModel(RxLoginPageViewModel) -> ViewModel
    let postLogin = PublishRelay<LoginUser>()
    
    init() {
        buttonTapped
            .withLatestFrom(postLogin) { $1 }
            .bind(onNext: <#T##(LoginUser) -> Void#>)
        
    }
    
    private func logIn(loginUser: LoginUser) {
        self.httpManager.s
    }
    
}

