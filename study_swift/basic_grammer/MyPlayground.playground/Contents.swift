import UIKit

func sum(a: Int, b: Int) -> Int {
    return a + b
}

func sum(a: Double, b: Double) -> Double {
    return a + b
}

func subtract(a: Int, b: Int) -> Int {
    return a - b
}

print(sum(a:1 , b:3))
print(sum(a:1.5 , b:3.2))
print(sum(a:2, b: 1.5))

func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = function(a, b)
    print(result)
}

printResult(sum, 10, 5)
printResult(subtract, 10, 5)
//inout
// switch
// for문

// ---- optional: 값이 있을수도 없을 수도
var carName: String?
carName = nil
carName = "탱크"

// 1. 최애하는 연애인 이름을 담는 변수를 작성하기(타입 String?)
var name: String? = "지수"
name = nil

// 2. let num = Int("10") -> 타입은 뭘까??
let num = Int("10") // ->이건 옵셔널 int
let num2 = 10


// 고급 기능 4가지

// Forced unwrapping > 억지로 박스를 까보기
// Optional binding (if let) > 부드럽게 박스를 까보자 1
// Optional binding (guard) > 부드럽게 박스를 까보자 2
// Nul coalescing > 박스를 까봤더니, 값이 없으면 디폴트 값을 줘보자

// Forced unwrapping
print(carName! as String) // carName이 있다고 확신, 없으면 에러 ex)carName = nil

// Optional binding (if let)
if let unwrappedCarName = carName {
    print(unwrappedCarName)
} else {
    print("Car Name 없다")
}

func printParsedInt(from: String) {
    if let parsedInt = Int(from) {
        print(parsedInt)
        // Cyclomatic Complexity(복잡도 측정) -> 잘고려해서 코딩
    } else {
        print("Int로 컨버팅 안된다")
    }
}
printParsedInt(from: "100")
printParsedInt(from: "헬로우")

// Optional binding (guard)
func printParsedInt2(from: String) {
    guard let parsedInt = Int(from) else {
        print("Int로 컨버팅 안된다")
        return
    }
    print(parsedInt)
}


// Nul coalescing
let carName2: String? = nil
let myCarName: String = carName2 ?? "모델 S"
print(myCarName)

print()
// --- 도전 과제
// 1. 최애 음식이름을 담는 변수를 작성하세요 (String?)
let food: String? = nil
// 2. 옵셔널 바인딩을 이용해서 값을 확인해보기
//print(food)
//print(food!)
func printFood(food: String?) {
    guard let tempFood = food else {
        print("문자열화 안된다")
        return
    }
    print(tempFood)
}
printFood(food: food)

let resultFood: String = food ?? "치킨"
print("최애음식: " + resultFood)
// 3. 닉네임을 받아서 출력하는 함수 만들기, 조건 입력 파라미터는 String?

func printNickName(nickname: String?) {
    if let name = nickname {
        print(name)
    } else {
        print("올바른 닉네임을 입력하시오")
        return
    }
}
printNickName(nickname: nil)


func printNickName2(nickname: String?) {
    guard let name = nickname else {
        print("올바른 닉네임을 입력하시오")
        return
    }
    print(name)
}
printNickName2(nickname: nil)

func printNickName3(nickname: String?) {
    if (nickname == nil) {
        print("올바른 닉네임을 입력하시오")
        return
    }
    print(nickname!)
}
printNickName3(nickname: nil)

print()
// ---- array
var evenNumbers: [Int] = [2, 4, 6, 8]
var evenNumbers2: Array<Int> = [2, 4, 6, 8]

evenNumbers.append(10)
evenNumbers2.append(10)  // js에서 const는 값추가가 가능했는데 swift는 값까지도 보호하는 모양
evenNumbers += [11, 13, 15]
evenNumbers.append(contentsOf: [12, 30])

let isEmpty = evenNumbers.isEmpty

evenNumbers.count
evenNumbers.first // 왜 옵셔널이지???? -> 아이템이 없을 수도 있으니깐
print(evenNumbers.first)
evenNumbers = [] // -> 이런식으로

evenNumbers = [1, 2, 3]
if let firstElement = evenNumbers.first {
    print("--> first item is:\(firstElement)")
}

evenNumbers.min()
evenNumbers.max()

var firstItem = evenNumbers[0]
var secondItem = evenNumbers[1]

// ------->

let firstThree = evenNumbers[0...2]
evenNumbers.contains(3)
evenNumbers
evenNumbers.insert(0, at: 2) // 기존 index 2의 값부터 뒤로밀림

evenNumbers.removeAll()
evenNumbers

evenNumbers = [1,2,3,4,5]
evenNumbers.remove(at:2)
evenNumbers

evenNumbers[0] = -2
evenNumbers

evenNumbers[0...2] = [2, 1, 0]
evenNumbers

evenNumbers.swapAt(0, 3)

for num in evenNumbers {
    print(num)
}

for (index, num) in evenNumbers.enumerated() {
    print("idx: \(index), value: \(num)")
}


evenNumbers = [1,2,3,4,5]

// 앞에 2개 제외하고 가져오기
let firstTwoRemoved = evenNumbers.dropFirst(2)
evenNumbers
firstTwoRemoved

// 뒤에 2개 제외하고 가져오기
let lastTwoRemoved = evenNumbers.dropLast(2)
evenNumbers
lastTwoRemoved

// 앞에 2개 가져오기
let firstTwo = evenNumbers.prefix(2)
evenNumbers
firstTwo

// 뒤에 2개 가져오기
let lastTwo = evenNumbers.suffix(2)
evenNumbers
lastTwo

///Array 메서드가 많은데 그중에 중요한 것
/// 1. isEmpty
/// 2. count
/// 3. for루프에서 index 하나씩 접근하기

print()
///------> Dictionary: key를 이용해서관리 vs Array는 순서로 관리
///
var scoreDic: [String: Int] = ["Jason":80, "Jay": 95, "Jake":90]
var scoreDic2: Dictionary<String, Int> = ["Jason":80, "Jay": 95, "Jake":90]

scoreDic["Jason"]
scoreDic["Jay"]

///여기서 잠깐 튜플을 본다면
let coordinates = (4, 6)
let x = coordinates.0

let coordinates2 = (x:"hi", y:4)
let x2 = coordinates2.x
///

scoreDic["ss"] // 없는값을 넣으면 nil
// 안정적으로 가져오기
if let score = scoreDic["Jason"] {
    score
} else {
    // .. score 없음
}

scoreDic = [:]
scoreDic.isEmpty

scoreDic = ["Jason":80, "Jay": 95, "Jake":90]
scoreDic.count

// 기존 사용자 업데이트
scoreDic["Jason"] = 99
scoreDic

// 사용자 추가
scoreDic["Jack"] = 100
scoreDic

// 사용자 제거
scoreDic["Jack"] = nil
scoreDic


//for Loop
for (name, score) in scoreDic {
    print("\(name), \(score)")
}

for key in scoreDic.keys {
    print(key)
}

// 도전과제
// 1 이름 , 직업, 도시 에대해서 본인의 딕셔너리 만들기
var myDic:[String: String] = ["name": "kirim", "job": "student", "city": "seoul"]
// 2 여기서 도시를 부산으로 업데이트 하기
myDic["city"] = "busan"
// 3 딕셔너리를 받아서 이름과 도시 프린트하는 함수 만들기
func printNameAndCity(dic:[String: String]) {
    if let name = dic["name"], let city = dic["city"] {
        print("\(name) \(city)")
    } else {
        print("---> Cannot find")
    }
}
printNameAndCity(dic: myDic)


//---------Set: 순서가 중요하지않고 중복이없는 유니크한 아이템을 다룰때

var someArray: Array<Int> = [1, 2, 3, 1]
var someSet: Set<Int> = [1, 2, 3, 1, 3, 2]

someSet.isEmpty
someSet.count

someSet.contains(4)
someSet.contains(1)

someSet.insert(5)
someSet

someSet.remove(1)
someSet



// --------closure: 이름없는 메소드
//<방법 1>
var multiplyClosure2: (Int, Int) -> Int = { a, b in
    return a * b
}
//<방법 2>
var multiplyClosure: (Int, Int) -> Int = { $0 * $1 }

let result = multiplyClosure(4, 2)

func operateTwoNum(a: Int, b: Int, opertion: (Int, Int) -> Int) -> Int {
    let result = opertion(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, opertion: multiplyClosure)

var addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}
operateTwoNum(a: 4, b: 2, opertion: addClosure)

operateTwoNum(a: 4, b: 2) { a, b in
    return a / b
}

let voidClosure: () -> Void = {
    print("iOS 개발자, 클로저 사랑해")
}
voidClosure()


// Capturing Values

var count = 0

let incrementer = {
    count += 1
}

incrementer()
incrementer()
incrementer()
incrementer()

count

// --- closure 보충내용
let sample = 12;

switch sample {
    case 1:
        print("1")
    case 2...9:
        print("2 ~ 9")
    case 10:
        print("10")
    case 11, 12, 13:
        print("11 or 12 or 13")
    default:
        print("nothing")
}
