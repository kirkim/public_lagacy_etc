//
//  Testtext.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/31.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SampleVC: UIViewController {
    private let disposeBag = DisposeBag()
    private let textField = UITextField()
    private let lengthLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: SampleViewModel = SampleViewModel(maxNumber: 6)) {
        textField.rx.text.orEmpty
            .bind(to: viewModel.textObservable)
            .disposed(by: disposeBag)

        viewModel.currentLength
            .emit { [weak self] str in
                self?.lengthLabel.text = str
            }
            .disposed(by: disposeBag)

        viewModel.isEditable
            .emit(onNext: { [weak self] isEditable in
                if !isEditable {
                    self?.textField.text = String(self?.textField.text?.dropLast() ?? "")
                }
            })
            .disposed(by: disposeBag)
    }

    func setUI() {
        self.view.backgroundColor = .white
        
        lengthLabel.font = .systemFont(ofSize: 25, weight: .bold)
        lengthLabel.textColor = .black
        
        textField.font = .systemFont(ofSize: 25, weight: .medium)
        textField.backgroundColor = .systemGray5
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        [lengthLabel, textField].forEach {
            self.view.addSubview($0)
        }
        
        lengthLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(300)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(lengthLabel).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
    }
}
