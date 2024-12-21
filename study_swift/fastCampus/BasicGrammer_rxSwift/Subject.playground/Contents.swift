import RxSwift

let disposeBag = DisposeBag()

print("------publishSubject------")
// publishSubject는 구독 이후의 이벤트를 받아올 수 있음
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세요")

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print("첫번째 구독자: ", $0)
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안들리시나요?"))

구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("두번째 구독자: ", $0)
    })

publishSubject.onNext("4. 여보세요")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝났나요")

구독자2.dispose()

publishSubject
    .subscribe {
        print("세번째 구독:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. 찍힐까요?")

print("------behaviorSubject------")
// behaviorSubject는 직전의 이벤트하나를 받아올 수 있음
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")

behaviorSubject.onNext("1. 첫번째값")

behaviorSubject.subscribe {
    print("첫번째구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("두번째구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value() // 이런식으로 value값을 추출할 수 있음
print(value)

print("------ReplaySubject------")
// 버퍼사이즈만큼의 이전 이벤트를 받아올 수 있음
let replaySubject = ReplaySubject<String>.create(bufferSize: 5)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject.subscribe {
    print("첫번째구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두번째구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 할 수 있어요.")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째구독: ", $0.element ?? $0)
}
.disposed(by: disposeBag)
