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
    
    //Searchbar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>() // error를 받을 필요없기때문에 subject대신 relay이용
    
    //SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        //searchbar search button tapped
        //button tapped
        //위에 두가지가 발생한 것을 탭이벤트로 본다 (두가지를 merge로 묶은다)
        //두개 모두 옵저버블로 만들어주기위해 asObservable을 이용
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped) // 두가지 이벤트가 발생할때마다 해당변수로 바인딩됨
            .disposed(by: disposeBat)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing) // extension 으로 SearchBar에 만들어줌
            .disposed(by: disposeBat)
        
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }  // 검색에 입력중 가장 최근텍스트를 보냄
            .filter { !$0.isEmpty } // 빈값을 보내지 않도록
            .distinctUntilChanged() // 중복값을 보내지 않도록
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
