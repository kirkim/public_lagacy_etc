//
//  MainRequestData.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//
import Foundation

class MainRequestData {
    static let shared = MainRequestData()
    private var dataModel: DataModel?
    private var isReady: Bool = false
    
    private init() { }
    
    public func readyData() {
        let session = URLSession.shared
        
        let components = URLComponents(string: "http://localhost:8080")
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, res, error in
            if let hasData = data {
                do {
                    self.dataModel = try JSONDecoder().decode(DataModel.self, from: hasData)
                    self.isReady = true
                } catch {
                    print(error)
                }
            }
        }.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func getData() -> DataModel? {
        if (self.isReady == false) {
            usleep(100000)
            return getData()
        }
        return self.dataModel
    }
}
