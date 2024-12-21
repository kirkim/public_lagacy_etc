//
//  ContentView.swift
//  Practice12_29
//
//  Created by 김기림 on 2021/12/29.
//

import SwiftUI

enum Grade: String, CaseIterable {
    case element = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case uni = "대학교"
    
    var id: String { self.rawValue }
}

enum Gender: String, CaseIterable {
    case male = "남자"
    case female = "여자"
    
    var id: String { self.rawValue }
}

struct UserSchema: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var grade: Grade
    var gender: Gender
    
    init (_ name: String, _ grade: Grade, _ gender: Gender) {
        self.name = name
        self.grade = grade
        self.gender = gender
    }
}

func makeRandomUsers() -> [UserSchema] {
    var randomUsers = [UserSchema]()
    
    for i in 1..<50 {
        let user = UserSchema("학생\(i)", Grade.allCases.randomElement()!, Gender.allCases.randomElement()!)
        randomUsers.append(user)
    }
    return randomUsers
}

struct ContentView: View {
    
    @State var selectedGrade: Grade = .element
    @State var selectedGender: Gender = .male
    @State var randomUsers = [UserSchema]()
    
    init() {
        _randomUsers = State(initialValue: makeRandomUsers())
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("학교")
                Picker("grade", selection: $selectedGrade) {
                    ForEach(Grade.allCases, id: \.id, content: {
                        Text($0.rawValue).tag($0)
                    })
                }.pickerStyle(SegmentedPickerStyle())
            } // HStack
            .padding(.horizontal)
            
            HStack {
                Text("성별")
                Picker("gender", selection: $selectedGender) {
                    ForEach(Gender.allCases, id: \.id, content: {
                        Text($0.rawValue).tag($0)
                    })
                }.pickerStyle(SegmentedPickerStyle())
            } // HStack
            .padding(.horizontal)
            
            List {
                Section {
                    ForEach(self.randomUsers.filter({ user in
                        return (user.grade == self.selectedGrade) && (user.gender == self.selectedGender)
                    }), id: \.id) { data in
                        HStack {
                            Spacer()
                            Text(data.name)
                            Spacer()
                            Text(data.grade.rawValue)
                            Spacer()
                            Text(data.gender.rawValue)
                            Spacer()
                        }
                    }
                } header: {
                    HStack {
                        Spacer()
                        Text("이름")
                        Spacer()
                        Text("학교")
                        Spacer()
                        Text("성별")
                        Spacer()
                    }
                }
            } // List
        } // VStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
