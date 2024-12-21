//
//  SubRequestData.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

import Foundation

class SubRequestData {
    static let shared = SubRequestData()
    private var dataModel: DataModel?
    private var isReady: Bool = false
    
    private init() { }
    
    public func getData() async -> DataModel? {
        let session = URLSession.shared
        
        let components = URLComponents(string: "http://localhost:8080")
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
//        session.dataTask(with: request) { data, res, error in
//            if let hasData = data {
//                do {
//                    self.dataModel = try JSONDecoder().decode(DataModel.self, from: hasData)
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            self.dataModel = try JSONDecoder().decode(DataModel.self, from: data)
        } catch {
            print(error)
        }
//        let task = session.dataTask(with: request)
//        task.resume()
//        session.finishTasksAndInvalidate()
        return self.dataModel
    }
}
