//
//  Repository.swift
//  Practice_RxswiftBySPM
//
//  Created by 김기림 on 2022/03/14.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
}
struct item: Codable {
    
}
