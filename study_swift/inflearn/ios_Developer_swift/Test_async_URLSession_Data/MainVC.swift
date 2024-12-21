//
//  ViewController.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

import UIKit

class MainVC: UIViewController {
    private var myData: DataModel?
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
//        self.setData()
//        self.getData()
//        self.badGetData()
        self.useQue()
        let kirQueue = DispatchQueue(label: "kirkim")
        kirQueue.async {
            sleep(2)
            print("first")
        }
        kirQueue.async {
            print("second")
        }
    }
    
    private func useQue() {
        let kirQueue = DispatchQueue(label: "kir")

        self.myData = UseLabelQueRequestData.shared.getData()
        self.mainTableView.reloadData()
        kirQueue.async {
        }
        kirQueue.async {
            DispatchQueue.main.async {
            }
        }
    }
    
    private func setData() {
//        MainRequestData.shared.readyData()
        Task {
            
            self.myData = await SubRequestData.shared.getData()
            self.mainTableView.reloadData()
        }
        DispatchQueue.main.async {
//            self.myData = MainRequestData.shared.getData()
        }
    }
    
    private func badGetData() {
        guard let url = URL(string: "http://localhost:8080") else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                self.myData = try JSONDecoder().decode(DataModel.self, from: data)
//                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
//                }
            } catch {
                print(error)
            }
        }
    }
    
    private func getData() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
//        let session = URLSession.shared
        
        let components = URLComponents(string: "http://localhost:8080")
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request) { data, res, error in
            if let hasData = data {
                do {
                    self.myData = try JSONDecoder().decode(DataModel.self, from: hasData)
                    DispatchQueue.main.async {
                        self.mainTableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        session.finishTasksAndInvalidate()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.indexCnt.text = (indexPath.row + 1).description
        cell.nameLabel.text = "이름: " + (self.myData?.results[indexPath.row].username ?? "")
        cell.genderLabel.text = "성별: " + (self.myData?.results[indexPath.row].gender ?? "")
        cell.ageLabel.text = "나이: " + (self.myData?.results[indexPath.row].age.description ?? "")

        return cell
    }
}
