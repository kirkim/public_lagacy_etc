import UIKit

/* 프로퍼티 감시자 */

// 프로퍼티 감시자를 사용하면 프로퍼티 값이 변경될 때 원하는 동작을 수행할 수 있습니다.
//MARK: - 정의

struct Money {
    // 프로퍼티 감시자 사용1
    var currencyRate: Double = 1100 {
        willSet(newRate) {
            print("환율이 \(currencyRate)에서 \(newRate)으로 변경될 예정입니다")
        }
        didSet(oldRate) {
            print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다")
        }
    }
    
    // 프로퍼티 감시자 사용2
    var dollar: Double = 0 {
        willSet {
            print("환율이 \(currencyRate)에서 \(newValue)으로 변경될 예정입니다")
        }
        didSet {
            print("환율이 \(oldValue)에서 \(currencyRate)으로 변경되었습니다")
        }
    }
    
    // 연산 프로퍼티
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            dollar = newValue / currencyRate
        }
        
        /* 프로퍼티 감시자와 연산 프로퍼티 기능을 동시에 사용할 수 없습니다
        willSet {
         
        }
        */
    }
}

var moneyInMyPocket: Money = Money()
moneyInMyPocket.currencyRate = 1150
moneyInMyPocket.dollar = 10

// MARK: - 상속
class Person {
    var name: String = ""
    
    func selfIntroduce() {
        print("저는 \(name)입니다")
    }
    
    // final 키워드를 사용하여 재정의를 방지할 수 있습니다
    final func sayHello() {
        print("hello")
    }
    
    // 타입 메서드
    // 재정의 불가 타입 메서드 - static
    static func typeMethod() {
        print("type method - static")
    }
    
    // 재정의 가능 타입 메서드 - class
    class func classMethod(){
        print("type method - class")
    }
    
    // 재정의 가능한 class 메서드라도
    // final 키워드를 사용하면 재정의 할 수 없습니다
    // 메서드 앞의 `static`과 `final class`는 똑같은 역할을 합니다
    final class func finalCalssMethod() {
        print("type method - final class")
    }
}

class Student: Person {
    // var name: String = ""
    var major: String = ""
    
    override func selfIntroduce() {
        print("저는 \(name)이고, 전공은 \(major)입니다")
    }
    
    override class func classMethod() {
        print("overriden type method - class")
    }
    
    // static을 사용한 타입 메서드는 재정의 할 수 없습니다
    // override static func typeMethod() { }
    
    // final 키워드를 사용한 메서드, 프로퍼티는 재정의 할 수 없습니다
    // override func sayHello() { }
    // override class func finalClassMethod() { }
}
