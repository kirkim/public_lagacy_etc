//
//  RxHttpClient.swift
//  kirkim_App
//
//  Created by 김기림 on 2022/03/25.
//

import RxSwift
import Foundation

struct CheckId: Codable {
    var userID: String
}

enum CustomError: Error {
    case invalidURL
    case decodingError
    case responseError
    case noData
    case error(Error)
    case code(Int)
    
    var msg: String {
        switch self {
        case .invalidURL:
            return "InValid URL"
        case .decodingError:
            return "Decoding Error"
        case .noData:
            return "No Data"
        case .responseError:
            return "Response Error"
        case .error(let err):
            return err.localizedDescription
        case .code(let code):
            return "\(code) Error"
        }
    }
}

enum UserPostType: String, UrlType {
    case login
    case signUp
    case checkId
    
    var url: String {
        let BASE_URL: String = "http://localhost:8080"
        switch self {
        case .login:
            return "\(BASE_URL)/user/login"
        case .signUp:
            return "\(BASE_URL)/user/signup"
        case .checkId:
            return "\(BASE_URL)/user/checkid"
        }
    }
}
enum UserGetType: String, UrlType {
    case usersData__Dev
    
    var url: String {
        let BASE_URL: String = "http://localhost:8080"
        switch self {
        case .usersData__Dev:
            return "\(BASE_URL)/user"
        }
    }
}


protocol UrlType {
    var url: String { get }
}


class RxHttpClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    typealias RequestValue = (value: String, key: String)
    func postHttp<T: Codable>(type postType: UrlType, body: T, headers: [RequestValue]?) -> Single<Result<Data, CustomError>> {
        guard let url = URL(string: postType.url) else {
            return .just(.failure(.invalidURL))
        }
        guard let uploadData = try? JSONEncoder().encode(body) else {
            return .just(.failure(.decodingError))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        request.httpBody = uploadData
        return session.rx.response(request: request)
            .flatMap { response, data -> Single<Result<Data, CustomError>> in
                if (200..<300 ~= response.statusCode) {
                    return .just(.success(data))
                } else {
                    return .just(.failure(.responseError))
                }
            }
            .asSingle()
    }
    
    func getHttp(type postType: UrlType, headers: [RequestValue]?) -> Single<Result<Data, CustomError>> {
        guard let url = URL(string: postType.url) else {
            return .just(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return session.rx.response(request: request)
            .flatMap { response, data -> Single<Result<Data, CustomError>> in
                if(200..<300 ~= response.statusCode) {
                    return .just(.success(data))
                }
                return .just(.failure(.responseError))
            }
            .asSingle()
    }
}
