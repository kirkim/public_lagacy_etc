import RxSwift

print("-----Just-----") // element 한개만 방출
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of-----") // element 여러개 방출 가능
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("-----Of2-----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("-----From-----") // Array속 element들을 하나씩방출
Observable.from([1, 2, 3, 4 , 5])
    .subscribe(onNext: {
        print($0)
    })

print("-----subscribe1-----")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("-----subscribe3-----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("-----empty-----")
Observable<Void>.empty() // empty같은 경우 type추론이 안되기에 Void를 적는 것이 적절
    .subscribe(onNext: {
        
    },
    onCompleted: {
        print("Completed")
    })

// 위의 empty()케이스를 요약하면 다음과 같음
// 용도: 즉시종료하는 옵저버블, 의도적으로 0개의 옵저버블을 리턴해줄 때
print("-----empty2-----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }


print("-----never-----")
//Observable<Void>.never()
//    .debug("never")
//    .subscribe {
//        onNext: {
//            print($0)
//        },
//        onCompleted: {
//            print("Completed")
//        }
//    }
print("-----range-----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })

print("-----dispose-----")
// 밑에 예시에서는 3개요소라 별차이를 못느끼지만 무한한 요소를 가질때는 반드시 dispose()를 호출해 줘야함
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("-----disposeBag-----")
// 옵저버블을 좀 더 관리하기가 좋아짐(실수로 발생한 메모리누수문제를 해결할 수 있음)
let disposeBag = DisposeBag()

Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

print("-----create1-----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.on(.next(1))
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----create2-----")
enum MyError: Error {
    case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

print("-----deffered1-----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("-----deffered2-----")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("🍔")
    } else {
        return Observable.of("🍕")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
