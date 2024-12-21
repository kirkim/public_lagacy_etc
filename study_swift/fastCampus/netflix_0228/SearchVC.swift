//
//  SearchVC.swift
//  netflix_0228
//
//  Created by 김기림 on 2022/02/28.
//

import UIKit
import Kingfisher
import AVFoundation

class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

//MARK: - SearchVC: UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    private func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              text.isEmpty == false else { return }
        
        dismissKeyboard()
        print("\(text)를 입력했습니다.")
        SearchAPI.search(text, completion: { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

//MARK: - Search: UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PlayerVC.init(nibName: "PlayerVC", bundle: nil)
        let previewURL = URL(string: self.movies[indexPath.row].preViewURL)!
        let playerItem = AVPlayerItem(url: previewURL)
        vc.player.replaceCurrentItem(with: playerItem)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - SearchVC: UICollectionViewDataSource
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        let urlString = self.movies[indexPath.row].thumbnail
        let url = URL(string: urlString)!
        cell.thumbnail.kf.setImage(with: url)
        return cell
    }
}

//MARK: - SearchVC: UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let margin: CGFloat = 8
        let width: CGFloat = (self.collectionView.frame.width - (spacing * 2) - (margin * 2)) / 3
        let height: CGFloat = width * (10/7)
        return CGSize(width: width, height: height)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - SearchAPI
class SearchAPI {
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void) {
        let session = URLSession.init(configuration: .default)
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        print(requestURL)
        session.dataTask(with: requestURL, completionHandler: { data, response, error in
            let successRange = 200..<300
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                      print("response error!")
                      completion([])
                      return
                  }
            guard let hasData = data else {
                print("no data!")
                completion([])
                return
            }
            let movies = SearchAPI.parseDataToMovies(data: hasData)
            completion(movies)
        }).resume()
    }
    
    static func parseDataToMovies(data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            return movies
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

//MARK: - struct Response, Movie
struct Response: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnail: String
    let preViewURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnail = "artworkUrl100"
        case preViewURL = "previewUrl"
    }
}
