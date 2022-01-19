//
//  ViewController.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import UIKit

class MainVC: UIViewController {

    var movieModel: ItunesDataModel?
    @IBOutlet weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        SubNetWorkingItunesAPI.shared.prepareData { model in
            self.movieModel = model
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        NetWorkingItunesAPI.shared.prepareData()
//        DispatchQueue.main.async {
//            self.movieModel = NetWorkingItunesAPI.shared.getData()
//            self.tableView.reloadData()
//        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: ", self.movieModel?.resultCount ?? 0)
        return self.movieModel?.results.count ?? 1
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("MainVC - tableView() cellForRowAt called / IndexPate.row: \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = movieModel?.results[indexPath.row].title
        cell.descriptionLabel.text = movieModel?.results[indexPath.row].shortDescription
        let currency = movieModel?.results[indexPath.row].currency ?? ""
        let price = movieModel?.results[indexPath.row].price.description ?? ""
        cell.priceLabel.text = "\(currency) \(price)"
        
        if let imageString = movieModel?.results[indexPath.row].image {
            loadImage(urlString: imageString) { image in
                DispatchQueue.main.async {
                    cell.movieImage.image = image
                }
            }
        }
        

        if let imageString = movieModel?.results[indexPath.row].image {
            guard let url = URL(string: imageString) else { return cell }

            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: data)
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        if let dateString = movieModel?.results[indexPath.row].date {
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString) {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy년 MM월 dd일"
                let resultDate = myFormatter.string(from: isoDate)
                cell.dateLabel.text = resultDate
            }
        }

        return cell
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void ) {
        print("MainVC - loadImage() called")
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
//        let session = URLSession.shared
        if let hasURL = URL(string: urlString) {
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            
            session.dataTask(with: request) { data, response, error in
                print("In loadImage() statusCode: ", (response as! HTTPURLResponse).statusCode)
                
                if let hasData = data {
                    completion( UIImage(data: hasData))
                    return
                }
            }.resume()
            session.finishTasksAndInvalidate()
        }
        
        completion(nil) // 위에 실행이 안됐을때 @escaping 된 메모리를 해제해줘야됨
    }
}

// MARK: - UISearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
}
