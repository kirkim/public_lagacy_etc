//
//  SubNetWorkingItunesAPI.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import Foundation

class SubNetWorkingItunesAPI {
    static let shared = SubNetWorkingItunesAPI()
    private var movieModel: ItunesDataModel?
    
    private init() { }
    
    public func prepareData(completion: @escaping (ItunesDataModel?) -> Void) {
        print("SubNetWorkingItunesAPI - prepareData() called")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let term = URLQueryItem(name: "term", value: "Marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        components?.queryItems = [term, media]
        guard let url = components?.url else { fatalError() }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            print( (response as! HTTPURLResponse).statusCode )
            print("url: \(url)")
            if let hasData = data {
                do {
                    sleep(1)
                    let movieModel = try JSONDecoder().decode(ItunesDataModel.self, from: hasData)
                    completion(movieModel)
                    return
                } catch {
                    print("error: ", error)
                }
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
        completion(nil)
    }
}
