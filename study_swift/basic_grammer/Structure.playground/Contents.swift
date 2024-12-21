import UIKit
import os

/////////// struct 사용 전 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// 문제: 가장 가까운 편의점 찾기

// 맨처음 시작시.... 코드

// 현재 스토어 위치들
let Nstore1 = (x:3, y: 5, name: "gs")
let Nstore2 = (x:4, y: 6, name: "seven")
let Nstore3 = (x:1, y: 7, name: "cu")


// 거리구하는 함수
func Ndistance(current: (x: Int, y: Int), target: (x: Int, y: Int)) -> Double {
    // 피타고라스..
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}


// 가장 가까운 스토어 구해서 프린트하는 함수
func NprintClosestStore(currentLocation:(x: Int, y: Int), stores:[(x: Int, y: Int, name: String)]) {
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    
    for store in stores {
        let distanceToStore = Ndistance(current: currentLocation, target: (x: store.x, y: store.y))
        closestStoreDistance = min(distanceToStore, closestStoreDistance)
        if closestStoreDistance == distanceToStore {
            closestStoreName = store.name
        }
    }
    print("Closest store: \(closestStoreName)")
}

// Stores Array 세팅, 현재 내 위치 세팅
let NmyLocation = (x: 2, y: 2)
let Nstores = [Nstore1, Nstore2, Nstore3]

// printCloserstStore 함수이용해서 현재 가장 가까운 스토어 출력하기
NprintClosestStore(currentLocation: NmyLocation, stores: Nstores)


// Improve Code
// - make Location struct
// - make Store struct


/// struct 사용후 @@@@@@@@@@@@@@@@@@
// 문제: 가장 가까운 편의점 찾기

// 맨처음 시작시.... 코드

struct Location {  //----> 개인적인 첫 인상 typescript에서 tpye키워드 같다
    let x: Int
    let y: Int
}

struct Store {
    let loc: Location
    let name: String
    let deliveryRange = 2.0
    
    func isDeliverable(userLoc: Location) -> Bool {
        let distanceToStore = distance(current: userLoc, target: loc) //---> distance함수 아래에 선언되어 있는데 사용가능 js와 비슷한 부분?
        return distanceToStore < deliveryRange
    }
}

// 현재 스토어 위치들
let store1 = Store(loc: Location(x: 3, y: 5), name: "gs")
let store2 = Store(loc: Location(x: 4, y: 6), name: "seven")
let store3 = Store(loc: Location(x: 1, y: 7), name: "cu")


// 거리구하는 함수
func distance(current: Location, target: Location) -> Double {
    // 피타고라스..
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}


// 가장 가까운 스토어 구해서 프린트하는 함수
func printClosestStore(currentLocation:Location, stores:[Store]) {
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    var isDeliverable = false
    
    for store in stores {
        let distanceToStore = distance(current: currentLocation, target: store.loc)
        closestStoreDistance = min(distanceToStore, closestStoreDistance)
        if closestStoreDistance == distanceToStore {
            closestStoreName = store.name
            isDeliverable = store.isDeliverable(userLoc: currentLocation)
        }
    }
    print("Closest store: \(closestStoreName), isDeliverable: \(isDeliverable)")
}

// Stores Array 세팅, 현재 내 위치 세팅
let myLocation = Location(x: 2, y: 5)
let stores = [store1, store2, store3]

// printCloserstStore 함수이용해서 현재 가장 가까운 스토어 출력하기
printClosestStore(currentLocation: myLocation, stores: stores)


// Improve Code
// - make Location struct
// - make Store struct




// ---- Class vs Structure
// class는 참조, structure는 복사

class PersonClass {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct PersonStruct {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


let pClass1 = PersonClass(name: "Jason", age: 5)
let pClass2 = pClass1
pClass2.name = "Hey"

pClass1.name
pClass2.name

var pStruct1 = PersonStruct(name: "Jason", age: 5)
var pStruct2 = pStruct1
pStruct2.name = "Hey"

pStruct1.name
pStruct2.name



// 도전 과제

// 1. 강의 이름, 강사 이름, 학생수를 가지는 Struct 만들기 (Lecture)
struct Lecture {

    var teacher: String
    var lecture: String
    var studentCnt: Int
}

// 2. 강의 어레이와 강사이름을 받아서, 해당 강사의 강의 이름을 출력하는 함수 만들기
func findLecture(lectures: [Lecture], teacher: String) {
//    for lec in lectures {
//        if (teacher == lec.teacher) {
//            print(lec.lecture)
//        }
//    }
    // 방법1
    let lectureName = lectures.first { (lec) -> Bool in
        return lec.teacher == teacher
    }?.lecture ?? ""
    print("아 그 강사님 강의는요: \(lectureName)")
    
    // 방법2
    let lectureName2 = lectures.first { $0.teacher == teacher }?.lecture ?? ""
    print("아 그 강사님 강의는요: \(lectureName2)")
}

// 3. 강의 3개 만들고 강사이름으로 강의찾기
let lec1 = Lecture(teacher: "kirim", lecture: "Math", studentCnt: 5)
let lec2 = Lecture(teacher: "Rose", lecture: "Science", studentCnt: 3)
let lec3 = Lecture(teacher: "jisoo", lecture: "English", studentCnt: 7)
let lecs = [lec1, lec2, lec3]
findLecture(lectures: lecs, teacher: "kirim")

print(lec1)


// 프로토콜 (위의 예시 이용)

struct Lecture2: CustomStringConvertible {
    var description: String {
        return "Title: \(lecture), Teacher: \(teacher)" // 설명을 이런식으로 입력
    }
    var teacher: String
    var lecture: String
    var studentCnt: Int
}

func findLecture2(lectures: [Lecture2], teacher: String) {
    var lectureName = ""
    for lec in lectures {
        if (teacher == lec.teacher) {
            lectureName = lec.lecture
        }
    }
    print("아 그 강사님 강의는요: \(lectureName)")
}

let lec4 = Lecture2(teacher: "kirim", lecture: "Math", studentCnt: 5)
let lec5 = Lecture2(teacher: "Rose", lecture: "Science", studentCnt: 3)
let lec6 = Lecture2(teacher: "jisoo", lecture: "English", studentCnt: 7)
let lecs2 = [lec4, lec5, lec6]

findLecture2(lectures: lecs2, teacher: "kirim")

print(lec4)  // 사람이 보기 쉽게 설명되어 출력됨

