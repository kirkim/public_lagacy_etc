//
//  PickerSchool.swift
//  pickerView
//
//  Created by 김기림 on 2021/12/28.
//

import SwiftUI

enum Grade: String, CaseIterable {
    case element = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    
    var id: String { self.rawValue }
}

struct StudentInfo: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var grade: Grade
    
    init(_ name: String, _ grade: Grade) {
        self.name = name
        self.grade = grade
    }
}

struct PickerSchool: View {
    func prepareData() -> [StudentInfo]{
        var newList = [StudentInfo]()
        
        for i in 0...20 {
            let newFriend = StudentInfo("내 친구 \(i)", Grade.allCases.randomElement()!)
            newList.append(newFriend)
        }
        return newList
    }
    
    @State private var myFriendsList = [StudentInfo]()
    // 생성자 메소드
    init() {
        _myFriendsList = State(initialValue: prepareData())
    }
    
//    private let studentData: [StudentInfo] = [
//        StudentInfo("학생1", .element),
//        StudentInfo("학생2", .high),
//        StudentInfo("학생3", .middle),
//        StudentInfo("학생4", .element),
//        StudentInfo("학생5", .element),
//        StudentInfo("학생6", .high),
//        StudentInfo("학생7", .high),
//        StudentInfo("학생8", .element),
//        StudentInfo("학생9", .middle),
//        StudentInfo("학생10", .element),
//        StudentInfo("학생11", .middle),
//        StudentInfo("학생12", .middle),
//        StudentInfo("학생13", .element),
//        StudentInfo("학생14", .element),
//        StudentInfo("학생15", .high),
//        StudentInfo("학생16", .high),
//        StudentInfo("학생17", .high),
//        StudentInfo("학생18", .element),
//        StudentInfo("학생19", .element),
//        StudentInfo("학생20", .high),
//    ]
    
    @State private var selectSchool: Grade = .element
    
    
    var body: some View {
        VStack {
            Text("\(self.selectSchool.rawValue)")
            Picker("ClassifySchool", selection: $selectSchool) {
                ForEach(Grade.allCases, id: \.id) { value in
                    Text(value.rawValue).tag(value)
                }
            }.pickerStyle(SegmentedPickerStyle())
            List {
                ForEach(self.myFriendsList.filter({ student in
                    return student.grade == self.selectSchool
                }), id: \.self) { data in
                    HStack {
                        Text("name: \(data.name)")
                        Text("school: \(data.grade.rawValue)")
                    }
                }
            } // List
        } // VStack
    }}

struct PickerSchool_Previews: PreviewProvider {
    static var previews: some View {
        PickerSchool()
    }
}
