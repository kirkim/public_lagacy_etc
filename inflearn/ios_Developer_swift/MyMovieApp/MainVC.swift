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
        NetWorkingItunesAPI.shared.prepareData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.movieModel = NetWorkingItunesAPI.shared.getData()
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: ", self.movieModel?.resultCount ?? 0)
        return self.movieModel?.results.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.titleLabel.text = movieModel?.results[indexPath.row].title
        cell.descriptionLabel.text = movieModel?.results[indexPath.row].shortDescription
        let currency = movieModel?.results[indexPath.row].currency ?? ""
        let price =  movieModel?.results[indexPath.row].price.description ?? ""
        cell.priceLabel.text = "\(currency) \(price)"
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
}
