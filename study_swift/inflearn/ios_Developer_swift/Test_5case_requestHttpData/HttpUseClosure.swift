//
//  HandlerURLSession.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import UIKit

class HttpUseClosure {
    static let shared = HttpUseClosure()
    
    private init() { }
    
    public func getData(completion: @escaping (DataModel?) -> Void) {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        guard let url = URL(string: "http://localhost:8080") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        session.dataTask(with: urlRequest) { data, res, error in
            guard let data = data else {
                print(error.debugDescription)
                return
            }
            do {
                sleep(2)
                let resultData = try JSONDecoder().decode(DataModel.self, from: data)
                completion(resultData)
            } catch {
                print(error)
            }
        }.resume()
        session.finishTasksAndInvalidate()
        completion(nil)
    }
}
