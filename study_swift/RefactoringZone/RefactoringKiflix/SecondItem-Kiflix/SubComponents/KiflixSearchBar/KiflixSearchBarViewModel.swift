//
//  KiflixSearchBarViewModel.swift
//  RefactoringKiflix
//
//  Created by 김기림 on 2022/03/21.
//

import RxSwift
import RxCocoa

struct KiflixSearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let searchButtonTapped = PublishRelay<Void>()
    
    let shouldLoadResult: Observable<String>
    
    init() {
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
}
