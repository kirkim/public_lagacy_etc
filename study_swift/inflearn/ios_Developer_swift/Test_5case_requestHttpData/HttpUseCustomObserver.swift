//
//  HttpUseCustomObserver.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import Foundation

class HttpUseCustomObserver {
    static let shared = HttpUseCustomObserver()
    private var dataModel: DataModel?
    private var isReady: Bool = false
    private var count = 0
    
    private init() { }
    
    public func readyData() {
        guard isReady == false else { return }
        let session = URLSession.shared
        
        let components = URLComponents(string: "http://localhost:8080")
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                sleep(2)
                self.dataModel = try JSONDecoder().decode(DataModel.self, from: data)
                self.isReady = true
            } catch {
                print(error)
            }
        }.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func getData() -> DataModel? {
        self.count += 1
        print("Call getData() \(self.count) times")
        if (self.isReady == false) {
            usleep(100000) // 0.1초
            return getData()
        }
        return self.dataModel
    }
}

