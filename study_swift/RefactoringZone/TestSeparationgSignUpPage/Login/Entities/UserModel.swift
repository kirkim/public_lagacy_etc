//
//  UserModel.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/02/16.
//

import Foundation
import RxSwift

struct UserModel {
    private let manager = UserManager.shared
    
    var isLogin: Bool {
        return manager.isLogin
    }
    
    var info: User? {
        return manager.info
    }
    
    func logIn(userID: String, password: String) -> Void {
        manager.logIn(userID: userID, password: password)
    }
    
    func logOut() {
        manager.logOut()
    }
}

final class UserManager {
    static let shared = UserManager()
    private let userHttpManager = RxUserHttpManager()
    private let disposeBag = DisposeBag()
    var info: User?
    var isLogin: Bool = false
    
    private init() { }
    
    private func setUser(user: User) {
        self.info = user
        self.isLogin = true
    }
    
    func logIn(userID: String, password: String) -> Single<Result<User, CustomError>> {
        let loginData = LoginUser(userID: userID, password: password)
        
        return userHttpManager.postFetch(type: .login, body: loginData)
            .flatMap { [weak self] result -> Single<Result<User, CustomError>> in
                switch result {
                case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode(User.self, from: data)
                        self?.setUser(user: dataModel)
                        self?.isLogin = true
                        return .just(.success(dataModel))
                    } catch {
                        print(error.localizedDescription)
                        return .just(.failure(.decodingError))
                    }
                case .failure(let customError):
                    return .just(.failure(customError))
                }
            }
    }
    
    func logOut() {
        self.info = nil
        self.isLogin = false
    }
}
