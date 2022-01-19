//
//  DataModel.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

//import Foundation

struct DataModel: Codable {
    let cnt: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case cnt = "resultCount"
        case results // 바꾸지 않는 변수도 선언
    }
}

struct Result: Codable {
    let username: String
    let age: Int
    let gender: String
}
