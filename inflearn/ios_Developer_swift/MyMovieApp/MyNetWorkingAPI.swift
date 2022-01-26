//
//  SubNetWorkingItunesAPI.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import UIKit

class MyNetWorking {
    static let shared = MyNetWorking()
    private var movieModel: ItunesDataModel?
    
    private init() { }
    
    public func getItunesData(movieTitle: String, completion: @escaping (ItunesDataModel?) -> Void) {
        print("SubNetWorkingItunesAPI - prepareData() called")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let term = URLQueryItem(name: "term", value: movieTitle)
        let media = URLQueryItem(name: "media", value: "movie")
        components?.queryItems = [term, media]
        guard let url = components?.url else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let res = response as? HTTPURLResponse,
                  res.statusCode == 200,
                  let hasData = data else {
                      print(error.debugDescription)
                      return
                  }
            do {
                let movieModel = try JSONDecoder().decode(ItunesDataModel.self, from: hasData)
                completion(movieModel)
                return
            } catch {
                print("error: ", error)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
        completion(nil)
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void ) {
//        print("MainVC - loadImage() called")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        if let hasURL = URL(string: urlString) {
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            
            session.dataTask(with: request) { data, response, error in
                guard let res = response as? HTTPURLResponse,
                      res.statusCode == 200,
                      let hasData = data else {
                          print(error.debugDescription)
                          return
                      }
                DispatchQueue.main.async {
                    completion( UIImage(data: hasData))
                }
                return
            }.resume()
            session.finishTasksAndInvalidate()
        }
        completion(nil) // 위에 실행이 안됐을때 @escaping 된 메모리를 해제해줘야됨
    }

    
}
