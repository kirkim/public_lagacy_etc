//
//  SearchBarViewModel.swift
//  RefactoringRxSwiftViewModel3_17
//
//  Created by 김기림 on 2022/03/17.
//

import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    //Searchbar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>() // error를 받을 필요없기때문에 subject대신 relay이용
//    var shouldLoadResult = Observable<String>.of("")
    //SearchBar 외부로 내보낼 이벤트
    let shouldLoadResult: Observable<String>
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }  // 검색에 입력중 가장 최근텍스트를 보냄
            .filter { !$0.isEmpty } // 빈값을 보내지 않도록
            .distinctUntilChanged() // 중복값을 보내지 않도록
    }
}
