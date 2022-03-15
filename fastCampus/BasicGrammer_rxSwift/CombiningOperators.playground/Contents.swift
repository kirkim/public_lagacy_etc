import RxSwift
import Foundation

let disposeBag = DisposeBag()


print("-------startWith1-------")
let 노랑반 = Observable<String>.of("👧🏻", "🧒🏽", "👦")

노랑반
    .startWith("👨🏻선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------startWith2-------")
let 파랑반 = Observable<String>.of("👧🏻", "🧒🏽", "👦")

파랑반
    .enumerated()
    .map { index, element in
        element + "어린이" + "\(index)"
    }
    .startWith("👨🏻선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concat1-------")
let 노랑반어린이들 = Observable<String>.of("👧🏻", "🧒🏽", "👦")
let 선생님 = Observable<String>.of("👨🏻선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concat2-------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------concatMap-------")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("👧🏻", "🧒🏽", "👦"),
    "파랑반": Observable.of("👶🏻", "👶🏿")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------merge1-------")
let 강북 = Observable.from(["강북구", "성북구", "동대문구", "종로구"])
let 강남 = Observable.from(["강남구", "강동구", "영등포구", "양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------merge2-------")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1) // 동시에 볼 옵저버블을 제한, 네트워크요청 연결수 재한 할때 사용(잘 사용은x)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest1-------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")


print("-------combineLatest2-------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(
        날짜표시형식,
        현재날짜,
        resultSelector: { 형식, 날짜 -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = 형식
            return dateFormatter.string(from: 날짜)
        })

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------combineLatest3-------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName, lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Stella")
firstName.onNext("Lily")


print("-------zip-------")
// combineLatest와 비슷해 보이지만 둘중하나의 observable이 끝나면 그대로 끝나버림
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승, .승)
let 선수 = Observable<String>.of("🇰🇷", "🇩🇰", "🇯🇵", "🇺🇦", "🇺🇸")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------withLatestFrom1-------")
let 🥊 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

🥊
    .withLatestFrom(달리기선수)
//    .distinctUntilChanged()  // sample처럼 동작
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("🏃🏻‍♀️")
달리기선수.onNext("🏃🏻‍♀️ 🏃🏼‍♂️")
달리기선수.onNext("🏃🏻‍♀️ 🏃🏼‍♂️ 🏃🏿")
🥊.onNext(Void())
🥊.onNext(Void())


print("-------sample-------")
// withLatestFrom과 비슷해보이지만 최초한번만 발동함
let 🏁출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(🏁출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🚗")
F1선수.onNext("🚗  🏎")
F1선수.onNext("🚗      🏎  🚓")
🏁출발.onNext(Void())
🏁출발.onNext(Void())
🏁출발.onNext(Void())


print("-------amb-------")
//element(요소)를 먼저 방출하는 Observable만 관찰함
let 🚌버스1 = PublishSubject<String>()
let 🚎버스2 = PublishSubject<String>()

let 🚏버스정류장 = 🚌버스1.amb(🚎버스2)

🚏버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

🚎버스2.onNext("버스2-승객0: 🐭")
🚌버스1.onNext("버스1-승객0: 🐹")
🚌버스1.onNext("버스1-승객1: 🦊")
🚎버스2.onNext("버스2-승객1: 🐶")
🚌버스1.onNext("버스1-승객1: 🐱")
🚎버스2.onNext("버스2-승객2: 🐯")


print("-------switchLatest-------")
// 마지막 시퀀스의 옵저버만 구독
let 👩🏻‍💻학생1 = PublishSubject<String>()
let 👩🏽‍💻학생2 = PublishSubject<String>()
let 👨‍💻학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest()

손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 저는 1번 학생입니다.")
👩🏽‍💻학생2.onNext("👩🏽‍💻학생2: 저는 15번 학생입니다.")

손들기.onNext(👩🏽‍💻학생2)
👩🏽‍💻학생2.onNext("👩🏽‍💻학생2: 다시 말하게요 저는 15번이에요!")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 야 내가 말하고 있자나")

손들기.onNext(👨‍💻학생3)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 이런 내말좀!!")
👩🏽‍💻학생2.onNext("👩🏽‍💻학생2: 너 말 씹힌듯ㅋㅋ")
👨‍💻학생3.onNext("👨‍💻학생3: 말하고 싶으면 손들고 말하라고!")

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 히히 그럼 내가 손들고 말해야지")
👩🏽‍💻학생2.onNext("👩🏽‍💻학생2: 하, 제발...")
👨‍💻학생3.onNext("👩🏻‍💻학생1: 아니 내차롄데..")
👩🏽‍💻학생2.onNext("👩🏽‍💻학생2: 이거 너무하네 손들기 싸움도 아니고")


print("-------reduce-------")
Observable.from((1...10))
    .reduce(0, accumulator: { summary, newValue in
        return summary + newValue
    })
//    .reduce(0, accumulator: +) // 축약해서 작성
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("-------scan-------")
// reduce와 동작은 동일하지만 새로운 element마다 결과를 보여줌
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
