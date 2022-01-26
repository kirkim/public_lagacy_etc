//
//  ViewController.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import UIKit

class MainVC: UIViewController {
    var errorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.isHidden = true
        return label
    }()
    var movieData: ItunesDataModel?
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        mySearchBar.delegate = self
        
        self.config()
    }
    
    private func config() {
        mySearchBar.autocapitalizationType = .none
        self.view.addSubview(self.errorLabel)
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.topAnchor.constraint(equalTo: self.mySearchBar.bottomAnchor, constant: 50).isActive = true
        self.errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("count: ", self.movieData?.resultCount ?? 0)
        return self.movieData?.results.count ?? 0
    }
    
    private func setCellSyncData(cell: inout MovieCell, cellForRowAt indexPath: IndexPath) {
        cell.titleLabel.text = movieData?.results[indexPath.row].title
        cell.descriptionLabel.text = movieData?.results[indexPath.row].shortDescription
        let currency = movieData?.results[indexPath.row].currency ?? ""
        let price = movieData?.results[indexPath.row].price.description ?? ""
        cell.priceLabel.text = "\(currency) \(price)"
    }
        
    private func getCellDate(cellForRowAt indexPath: IndexPath) -> String {
        guard let dateString = movieData?.results[indexPath.row].date else { return "" }
        let formatter = ISO8601DateFormatter()
        guard let isoDate = formatter.date(from: dateString) else { return "" }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 MM월 dd일"
        let resultDate = myFormatter.string(from: isoDate)
        
        return resultDate
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("MainVC - tableView() cellForRowAt called / IndexPate.row: \(indexPath.row)")
        var cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        setCellSyncData(cell: &cell, cellForRowAt: indexPath)
        cell.dateLabel.text = getCellDate(cellForRowAt: indexPath)
        if let imageString = movieData?.results[indexPath.row].image {
            MyNetWorking.shared.loadImage(urlString: imageString) { image in
                cell.movieImage.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = UIStoryboard(name: "DetailMovieVC", bundle: nil).instantiateViewController(withIdentifier: "DetailMovieVC") as? DetailMovieVC else { return }
        detailVC.resultData = self.movieData?.results[indexPath.row]
        self.navigationItem.title = "Home"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
    func toggleErrorMessage(isValid: Bool, message: String) {
        if isValid {
            self.errorLabel.isHidden = false
            self.errorLabel.text = message
            return
        } else {
            self.errorLabel.isHidden = true
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchValue = searchBar.searchTextField.text ?? ""
        MyNetWorking.shared.getItunesData(movieTitle: searchValue) { model in
            DispatchQueue.main.async {
                self.movieData = model
                if (searchValue.count > 5) {
                    searchValue = "\(searchValue.substring(from: 0, to: 5))..."
                }
                self.toggleErrorMessage(isValid: model?.resultCount == 0, message: "\"\(searchValue)\"를 찾을 수 없습니다.")
                self.tableView.reloadData()
            }
        }
    }
}
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        let startI = index(self.startIndex, offsetBy: from)
        let endI = index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startI ..< endI])
    }
}
