//
//  SearchBar.swift
//  Practice_RxswiftBySPM
//
//  Created by 김기림 on 2022/03/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBat = DisposeBag()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // MVVM패턴에서 View는 attribute()나 layout()과 같은 UI요소들만 관리해주면 된다.
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        // 서치바의 텍스트를 뷰모델의 queryText와 연결
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBat)
        
        //searchbar search button tapped
        //button tapped
        //위에 두가지가 발생한 것을 탭이벤트로 본다 (두가지를 merge로 묶은다)
        //두개 모두 옵저버블로 만들어주기위해 asObservable을 이용
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped) // 두가지 이벤트가 발생할때마다 해당변수로 바인딩됨
            .disposed(by: disposeBat)
        
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing) // extension 으로 SearchBar에 만들어줌
            .disposed(by: disposeBat)
        
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
