//
//  KiflixSearchBar.swift
//  RefactoringKiflix
//
//  Created by 김기림 on 2022/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class KiflixSearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: KiflixSearchBarViewModel) {
        
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        self.searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(searchButton.snp.leading).inset(10)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

extension Reactive where Base: KiflixSearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
