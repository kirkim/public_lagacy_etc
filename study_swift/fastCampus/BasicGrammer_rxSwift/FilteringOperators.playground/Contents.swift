import RxSwift

let disposeBag = DisposeBag()

print("------ignoreElements------")
let 취침모드 = PublishSubject<String>()

취침모드
    .ignoreElements()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

취침모드.onNext("🔊")
취침모드.onNext("🔊")
취침모드.onNext("🔊")

취침모드.onCompleted()

print("------elemaentAt------")
// 원하는 index값만 불러올 수있음
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔊") // index0
두번울면깨는사람.onNext("🔊") // index1
두번울면깨는사람.onNext("🌞") // index2
두번울면깨는사람.onNext("🔊") // index3

print("------filter------")
Observable.of(1, 2, 3 ,4 , 5, 6, 7, 8) // [1, 2 , 3 ,4 ,5 ,6 ,7 ,8]
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skip------")
// 처음부터 몇개의 요소를 skip해서 받아옴
Observable.of("😊", "🥰", "🤢", "😈", "🤠", "🥸")
    .skip(4)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skipWhile------")
// while에 요소가 나온 시점부터 받아옴
Observable.of("😊", "🥰", "🤢", "😈", "🤠", "🥸", "😊", "🥰")
    .skip(while: {
        $0 != "🤢" // 이걸 기준으로 뒤에를 출력해줌
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------skipUntil------")
// 다른옵저버블이 시도될때까지 skip했다가 받아옴
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님 // 현재 Observable
    .skip(until: 문여는시간) // 다른 Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("😊")
손님.onNext("🤢")

문여는시간.onNext("오픈!")

손님.onNext("🤠")

print("------take------")
// 원하는 값까지만 받아옴 skip과 반대되는 개념
Observable.of("😊", "🥰", "🤢", "😈", "🤠")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------takeWhile------")
// 해당조건 전까지 받아옴, 역시 skipWhile과 정반대
Observable.of("😊", "🥰", "🤢", "😈", "🤠")
    .take(while: {
        $0 != "🤢"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("------enumerated------")
// enumerated는 index까지 같이 출력해줌, 기존 swift 문법에도 있는 문법이기는 함
Observable.of("😊", "🥰", "🤢", "😈", "🤠")
.enumerated()
.takeWhile {
    $0.index < 3
}
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

print("------takeUntil------")
// until 조건까지만 받아옴, skipUntil과 정확히 반대개념
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()
Observable.of("😊", "🥰", "🤢", "😈", "🤠")

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("😊")
수강신청.onNext("🤢")

신청마감.onNext("끝!")
수강신청.onNext("😈")

print("------distinctUntilChanged------")
// 중복되는값을 필터링해줌
Observable.of("저는", "저는", "앵무새", "앵무새", "입니다", "입니다")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
