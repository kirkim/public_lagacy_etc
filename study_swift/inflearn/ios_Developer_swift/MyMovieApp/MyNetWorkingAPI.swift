//
//  SubNetWorkingItunesAPI.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import UIKit

enum MovieType {
    case url(urlString: String)
    case searchMovie(querys: [URLQueryItem])
}

enum MovieError:Error {
    case badUrl
}

typealias NetworkCompletion = (Data?, URLResponse?, Error?) -> Void

class MyNetWorking {
    static let shared = MyNetWorking()
    private var movieModel: ItunesDataModel?
    
    private init() { }
    
    public func request(movieType: MovieType, completion: @escaping NetworkCompletion) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do {
            var request = try requestUrl(movieType: movieType)
            request.httpMethod = "GET"
            session.dataTask(with: request) { data, response, error in
                guard let res = response as? HTTPURLResponse,
                      res.statusCode == 200 else {
                          print(error.debugDescription)
                          return
                      }
                completion(data, response, error)
                return
            }.resume()
            session.finishTasksAndInvalidate()
        } catch {
            print(error)
        }
        completion(nil, nil, nil)
    }
    
    private func requestUrl(movieType: MovieType) throws -> URLRequest {
        switch movieType {
        case .url(let urlString):
            guard let url = URL(string: urlString) else { throw MovieError.badUrl }
            return URLRequest(url: url)
        case .searchMovie(let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            guard let url = components?.url else { throw MovieError.badUrl }
            return URLRequest(url: url)
        }
    }
}
