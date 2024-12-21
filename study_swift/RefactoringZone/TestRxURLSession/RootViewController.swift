//
//  RootViewController.swift
//  TestRxURLSession
//
//  Created by 김기림 on 2022/03/29.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    let textField = UITextField()
    let disposBag = DisposeBag()
    let resultText = UILabel()
    let networkButton = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
        bind(RootViewModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: RootViewModel) {
        self.networkButton.rx.tap
            .withLatestFrom(self.textField.rx.text)
            .bind(to: viewModel.buttonTap)
            .disposed(by: disposBag)
        
        viewModel.presentAlert
            .subscribe(onNext: { result in
                let alert = UIAlertController(title: result, message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            })
            .disposed(by: disposBag)
    }
    
        
    private func attribute() {
        self.view.backgroundColor = .systemPink
        
        self.networkButton.setTitle(" 통신하기 ", for: .normal)
        self.networkButton.backgroundColor = .green
        self.networkButton.tintColor = .white
        self.networkButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        self.networkButton.layer.cornerRadius = 10
        
        self.resultText.backgroundColor = .gray
        self.resultText.numberOfLines = 0
        
        
    }
    
    private func layout() {
        self.view.addSubview(self.networkButton)
        self.view.addSubview(self.resultText)
        self.view.addSubview(self.textField)
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        self.networkButton.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        self.resultText.snp.makeConstraints {
            $0.top.equalTo(self.networkButton.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
    }
}
