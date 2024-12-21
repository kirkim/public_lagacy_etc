//
//  UseAsyncAwait.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import UIKit

//class HttpUseAsyncAwait {
//    static let shared = HttpUseAsyncAwait()
//
//    private init() { }
//
//    public func getData() async -> DataModel? {
//        let sessionConfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfiguration)
//
//        guard let url = URL(string: "http://localhost:8080") else { return nil }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//
//        var resultData: DataModel?
//        do {
//            sleep(2)
//            let (data, response) = try await session.data(for: urlRequest)
//            guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else { return nil }
//            resultData = try JSONDecoder().decode(DataModel.self, from: data)
//        } catch {
//            print(error)
//        }
//        return resultData
//    }
//}

class HttpUseAsyncAwait {
    static let shared = HttpUseAsyncAwait()
    
    private init() { }
    
    public func getData() async -> DataModel? {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        guard let url = URL(string: "http://localhost:8080") else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let request = urlRequest
        async let (data, response) = session.data(for: request)
        
        var resultData: DataModel?
        do {
            sleep(1)
            guard let httpResponse = try await response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else { return nil }
            resultData = try await JSONDecoder().decode(DataModel.self, from: data)
        } catch {
            print(error)
        }
        return resultData
    }
}
