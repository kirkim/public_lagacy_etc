import UIKit

/// ---closure
/*
{(param) -> return type in
    statement
    ...
}
*/

// Example 1: Cho Simple Closure
let choSimpleClosure = {
    
}

choSimpleClosure()

// Example 2: 코드블록을 구현한 Closure
let choSimpleClosure2 = {
    print("Hello, 클로져, 코로나 하이!")
}

choSimpleClosure2()

// Example 3: 인풋 파라미터를 받는 Closure
let choSimpleClosure3: (String) -> Void = { name in
    print("Hello, 클로져, 코로나 하이! 나의 이름은 \(name) 입니다!")
}

choSimpleClosure3("기림")

// Example 4: 값을 리턴하는 Closure
let choSimpleClosure4: (String) -> String = { name in
    let message = "iOS 개발 만만세, \(name)님 경제적 자유를 얻으실 거에요!"
    return message
}

let result = choSimpleClosure4("기림")
print(result)

// Example 5: Closure를 파라미터로 받는 함수 구현
func someSimpleFunction(choSimpleClosure: () -> Void) {
    print("함수에서 호출이 되었어요")
    choSimpleClosure()
}
let qqq = someSimpleFunction(choSimpleClosure:)
print(qqq)
someSimpleFunction(choSimpleClosure: {() -> Void in print("hi")})
someSimpleFunction(choSimpleClosure: {print("hello")})

// Example 6: Trailing Closure
func someSimpleFunction2(message: String, choSimpleClosure: () -> Void) {
    print("함수에서 호출이 되었어요, 메세지는 \(message)")
    choSimpleClosure()
}

someSimpleFunction2(message: "로나로나 메로나, 코로나 극혐", choSimpleClosure: {
    print("헬로 코로나 from closure")
})

func aaaa(message: String, choSimpleClosure: () -> Void) {
    print("함수에서 호출이 되었어요, 메세지는 \(message)")
    choSimpleClosure()
}

let sss = {() -> Void in (
    print("hi")
)
}
sss()

let sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in return a + b}
func ssssss(x a: Int, y b: Int, method: (Int, Int) -> Int) -> Int{
    return method(a, b)
}
print(ssssss(x:3, y:5, method: sum))



// 클로저 응용
var rresult: Int
// 후행 클로저: 마지막에 클로저가 전달이되면 함수 밖으로 빼줄 수 있음

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

rresult = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}
print(rresult)

// 반환 타입 생략: 이미 calculate라는 함수가 타입을 알고있을때 클로저의 반환형탑입을 명시해줄 필요가 없음
rresult = calculate(a: 20, b: 10) { (left: Int, right: Int) in
    return left + right
}
print(rresult)

//MARK: - 단축 인자이름
// 클로저의 매개변수 이름이 굳이 불필요하다면 단축 인자이름을 활용할 수 있습니다.
// 단축 인자이름은 크로저의 매개변수의 순서대로 $0, $1... 처럼 표현합니다
// in 도 생략됨
rresult = calculate(a: 10, b: 30, method: {
    return $0 + $1
})
// 당연히 후행 클로저와 함께 사용가능
rresult = calculate(a: 10, b: 30) {
    return $0 + $1
}
print(rresult)

//MARK: - 암시적 반환 표현
// 클로저가 반환하는 값이 있다면
// 클로저의 마지막 줄의 결과값은 암시적으로 반환값으로 취급합니다
// 단 한줄만 있어야함

rresult = calculate(a: 10, b: 50) {(left: Int, right: Int) in
    left + right
}
print(rresult)
rresult = calculate(a: 10, b: 60) {
    $0 + $1
}
print(rresult)

// 클로저의 축약이


//// 프로퍼티 잠깐보자

struct ERW {
    var a = "haha"
    var b = "kiki"
    
    // 읽기전용 인스턴스 연산 프로퍼티
    var aaaa: String {
        return "\(a) \(b)"
    }
    // 읽기전용2
    var bbbb: String {
        get {
            return "\(a) \(b)"
        }
    }
    // 읽기쓰기가능
    var cccc: String {
        get {
            return "\(a) \(b)"
        }
        set(input) {  // 구조체를 let으로 가져오면 사용못함
            a = input
        }
    }
    // 암시적으로 newValue로 사용가능
    var dddd: String {
        get {
            return "\(a) \(b)"
        }
        set {
            a = newValue
        }
    }
}
var rs = ERW()
print(rs)
print(rs.aaaa)
rs.cccc = "ya"
print(rs.aaaa)

// 위와같은 저장 프로퍼티와 연산 프로퍼티의 기능은
// 함수, 메서드, 클로저, 타입 등의 외부에 위치한
// 지역/전역 변수에도 모두 사용 가능합니다

var a: Int = 100
var b: Int = 200
var ssum: Int {
    return a + b
}

print(ssum) // 300
