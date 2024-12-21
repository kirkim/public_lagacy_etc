//
//  SampleViewModel.swift
//  TestSeparatingSignUpPage
//
//  Created by 김기림 on 2022/03/31.
//

import RxCocoa

struct SampleViewModel {
    //View -> ViewModel
    let textObservable = BehaviorRelay<String>(value: "")
    
    //ViewModel -> View
    let currentLength: Signal<String>
    let isEditable: Signal<Bool>
    
    init(maxNumber: Int) {
        let textObservable = textObservable.share()
        
        currentLength = textObservable
            .map { $0.count }
            .map({ nb in
                let currentNumber = nb > maxNumber ? nb - 1 : nb
                return "글자수: \(currentNumber) 최대글자수: \(maxNumber)"
            })
            .asSignal(onErrorJustReturn: "")
        
        isEditable = textObservable
            .map { $0.count <= maxNumber }
            .asSignal(onErrorJustReturn: false)

    }
}
