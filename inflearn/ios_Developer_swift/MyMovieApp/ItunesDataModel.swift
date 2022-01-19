//
//  ItunesDataModel.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import Foundation

struct ItunesDataModel: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let title: String
    let image: String
    let currency: String
    let price: Double
    let shortDescription: String?
    let longDescription: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case image = "artworkUrl100"
        case currency
        case price = "trackPrice"
        case shortDescription
        case longDescription
        case date = "releaseDate"
    }
}
