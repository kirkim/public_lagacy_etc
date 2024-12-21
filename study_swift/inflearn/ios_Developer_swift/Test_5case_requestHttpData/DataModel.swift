//
//  DataModel.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import Foundation

struct DataModel: Codable {
    let count: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
}

struct Result: Codable {
    let username: String
    let age: Int
    let gender: String
}
