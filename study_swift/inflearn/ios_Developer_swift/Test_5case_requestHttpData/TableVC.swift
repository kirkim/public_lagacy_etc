//
//  TableVC.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import UIKit

class TableVC: UIViewController, MyHttpDelegate {
    var myData: DataModel?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        // 1️⃣ use CustomFunction
        HttpUseCustomObserver.shared.readyData()
        DispatchQueue.global().async {
            self.myData = HttpUseCustomObserver.shared.getData()
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        
        // 2️⃣ use Closure
//        HttpUseClosure.shared.getData { data in
//            self.myData = data
//            DispatchQueue.main.async {
//                self.myTableView.reloadData()
//            }
//        }
        
        // 3️⃣ use async & await
//        Task(priority: .low) {
//            print("hi")
//            self.myData = await HttpUseAsyncAwait.shared.getData()
//            DispatchQueue.main.async {
//                self.myTableView?.reloadData()
//            }
//        }
//        Task(priority: .high) {
//            print("hello")
//        }
        
        // 4️⃣ use custom delegate
//        let httpUseDelegate = HttpUseCustomDelegate()
//        httpUseDelegate.myHttpDelegate = self
//        DispatchQueue.global().async {
//            httpUseDelegate.getData()
//        }
        
        // 5️⃣ use notificationCenter
//        let notificationName = NSNotification.Name("getDataNotification")
//        NotificationCenter.default.addObserver(self, selector: #selector(getDataUseNotification), name: notificationName, object: nil)
//        let httpUseNotification = HttpUseNotification(notificationName)
//        httpUseNotification.getData()
    }
    
    func getDataUseCustomDelgate(data: DataModel) {
        self.myData = data
        DispatchQueue.main.async {
            self.myTableView?.reloadData()
        }
    }
    
    @objc func getDataUseNotification(_ notification: Notification) {
        guard let data = notification.object as? DataModel else { return }
        self.myData = data
        DispatchQueue.main.async {
            self.myTableView?.reloadData()
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("getDataNotification"), object: nil)
    }
    
    @IBAction func handleGoBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - tableViewDelegate, TableViewDataSource
extension TableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 5
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.countLabel.text = (indexPath.row + 1).description
        cell.nameLabel.text = self.myData?.results[indexPath.row].username
        cell.ageLabel.text = self.myData?.results[indexPath.row].age.description
        cell.genderLabel.text = self.myData?.results[indexPath.row].gender
        
        return cell
    }
}
