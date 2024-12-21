import UIKit


// property
struct Person {
    // 저장 프로퍼티(Stored Properties)
    var firstName: String
    var lastName: String
    
    // 연산 프로퍼티(Computed Properties)
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            if let firstName = newValue.components(separatedBy: " ").first {
                self.firstName = firstName
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }
    
    // 타입 프로퍼티(Type Properties)
    static let isAlien: Bool = false
}

var person = Person(firstName: "Jason", lastName: "Kim")

person.firstName
person.lastName

person.firstName = "kirim"
person.lastName = "Lee"

person.firstName
person.lastName

person.fullName
person.fullName = "Jay Park"
person.fullName

Person.isAlien

/////@@@@@@@@@@@@@@@@@@@@@@
///@@@@@@@@@@@@@@@@@@@@@@

// property
struct Person2 {
    var firstName: String {
        // willSet은 바뀌기 직전
        willSet {
            print("willSet: \(firstName) --> \(newValue)")
        }
        // didSet은 바뀐 직후
        didSet {
            print("didSet: \(oldValue) --> \(firstName)")
        }
    }
    var lastName: String
    
    // lazy프로퍼티: (최적화용)굳이 사용할필요없을때 사용자가 접근할때 정의되어 호출됨(false일때 호출하면 쭉 false됨
    lazy var isPopular: Bool = {
        if fullName == "Jay Park" {
            return true
        } else {
            return false
        }
    }()
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            if let firstName = newValue.components(separatedBy: " ").first {
                self.firstName = firstName
            }
            if let lastName = newValue.components(separatedBy: " ").last {
                self.lastName = lastName
            }
        }
    }
    static let isAlien: Bool = false
}
var person2 = Person2(firstName: "kirim", lastName: "Kim")

person2.firstName
person2.lastName

person2.firstName = "Jisoo"
person2.lastName = "Lee"
person2.fullName = "Ro Se"

//person2.isPopular
person2.fullName = "Jay Park"
person2.isPopular


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@
// Property vs Method
struct sample {
    var firstName: String
    var lastName: String
    
    var sProperty: String {
        return "\(firstName) \(lastName)"
    }
    func sMethod() -> String {
        return "\(firstName) \(lastName)"
    }
}
// 프로퍼티 쓸까 메소드쓸가 다음과 같은 기준을 잡아보자
// Property: 호출시 (저장된)값을 하나 반환한다
// Method: 호출시 어떤 작업을 한다
// setter필요? ---> Computed Property
// setter필요없고 계산 많이 필요?(or DB access나 File io) ---> Method
// 다필요 없다 ---> Computed Property


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@
// struct와 관련된 method

struct Lecture {
    var title: String
    var maxStudents: Int = 10
    var numOfRegistered: Int = 0
    
    func remainSeats() -> Int {
        let remainSeats = maxStudents - numOfRegistered
        return remainSeats
    }
    
    mutating func register() { // 메소드가 스토어프로퍼티값을 변경시킨다면 mutating키워드를 붙여야한다.
        // 등록된 학생수 증가시키기
        numOfRegistered += 1
    }
    
    static let target: String = "Anybody want to learn something"
    
    static func 소속학원이름() -> String {
        return "42Seoul"
    }
}

var lec = Lecture(title: "iOS Basic")

//func remainSeats(of lec: Lecture) -> Int {
//    let remainSeats = lec.maxStudents - lec.numOfRegistered
//    return remainSeats
//}

lec.remainSeats()
lec.register()
lec.register()
lec.register()
lec.remainSeats()

Lecture.target
Lecture.소속학원이름()


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
struct Math {
    static func abs(value: Int) -> Int {
        if value > 0 {
            return value
        } else {
            return -value
        }
    }
}

Math.abs(value: -20)

// 제곱, 반값
extension Math {  // extension을 이용하여 내용을 추가할 수 있다
    static func sqaure(value: Int) -> Int {
        return value * value
    }
    
    static func half(value: Int) -> Int {
        return value / 2
    }
}

Math.sqaure(value: 5)
Math.half(value: 20)

// 그렇다면 굳이 왜 직접추가하지 왜 extension을 사용할까?
// 1. struct를 일리리 찾아서 수정하기 힘들고 여러사람과 작업할때 충돌이 일어날 가능성이 있다.
// 2. 다음과 같이 Int와 같이 애플프로그램제작자가 만든 것에도 추가해줄 수 있다.

var value: Int = 3

extension Int {  // 애플이 만든 Int에도 추가가 가능하다...
    func square() -> Int {
        return self * self
    }
    func half() -> Int {
        return self / 2
    }
}

value.square()
value.half()
