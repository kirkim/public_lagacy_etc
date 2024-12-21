//
//  UseLabelQueRequestData.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

import UIKit

class UseLabelQueRequestData {
    static let shared = UseLabelQueRequestData()
    private var dataModel: DataModel?
    
    private init() { }
    
    public func getData() -> DataModel? {
        let session = URLSession.shared
        
        let components = URLComponents(string: "http://localhost:8080")
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, res, error in
            if let hasData = data {
                do {
                    self.dataModel = try JSONDecoder().decode(DataModel.self, from: hasData)
                } catch {
                    print(error)
                }
            }
        }.resume()
        session.finishTasksAndInvalidate()
        sleep(1)
        return self.dataModel
    }
}

