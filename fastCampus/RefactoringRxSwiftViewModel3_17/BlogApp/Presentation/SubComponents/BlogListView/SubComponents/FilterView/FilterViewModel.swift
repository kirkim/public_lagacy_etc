//
//  FilterViewModel.swift
//  RefactoringRxSwiftViewModel3_17
//
//  Created by 김기림 on 2022/03/17.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    //FilterView 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()

}
