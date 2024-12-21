//
//  RootViewModel.swift
//  TestRxURLSession
//
//  Created by 김기림 on 2022/03/29.
//

import Foundation
import RxSwift
import RxCocoa

class RootViewModel {
    let buttonTap = PublishRelay<String?>()
    let presentAlert = PublishRelay<String>()
    let httpManager = RxUserHttpManager()
    let disposeBag = DisposeBag()
    
    init() {
        buttonTap
            .filter { $0 != nil }
            .map { $0! }
            .bind {
                self.checkId(id: $0)
            }
            .disposed(by: disposeBag)
    }
    
    private func checkId(id: String) {
        httpManager.checkUserId(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                switch result {
                case .success(let data):
                    do {
                        let json = try JSONDecoder().decode(Bool.self, from: data)
                        self.presentAlert.accept(json.description)
                    } catch {
                        print("catch error: ", error.localizedDescription)
                        self.presentAlert.accept("catch error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("fail error: ", error.localizedDescription)
                    self.presentAlert.accept("fail error: \(error.localizedDescription)")
                }
            } onFailure: { error in
                self.presentAlert.accept("fail!")
            } onDisposed: {
                print("disposed!")
            }
            .disposed(by: disposeBag)
    }

}
