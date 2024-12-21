//
//  ViewController.swift
//  Practice_datacore2
//
//  Created by 김기림 on 2022/02/01.
//

import UIKit
import CoreData

enum PriorityValue:Int64 {
    case low
    case normal
    case high
    var color: UIColor {
        switch self {
        case .low:
            return UIColor.green
        case .normal:
            return UIColor.yellow
        case .high:
            return UIColor.red
        }
    }
}

class MainVC: UIViewController, DetailVCDelegate {
    @IBOutlet weak var todoTableView: UITableView!
    private var todoDatas = Array<TodoList>()
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadConfig()
    }
    
    private func viewDidLoadConfig() {
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        
        let item = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        navigationItem.rightBarButtonItem = item
        updateData()
    }

    @objc private func addNewTodo() {
        let detailVC = DetailVC.init(nibName: "DetailVC", bundle: nil)
        detailVC.detailVCDelegate = self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    private func updateData() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest)
            self.todoDatas = data
        } catch {
            print(error)
        }
        self.todoTableView.reloadData()
    }
    
    func updateDataCompletion() {
        updateData()
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoDatas.count
    }
    
    private func myFormmatDate(date: Date?) -> String {
        guard let hasDate = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "YY-mm-dd hh:mm"
        return formatter.string(from: hasDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else { return TodoCell() }
        cell.todo.text = self.todoDatas[indexPath.row].todo
        cell.date.text = myFormmatDate(date: self.todoDatas[indexPath.row].date)
        cell.priorityView.backgroundColor = PriorityValue(rawValue: self.todoDatas[indexPath.row].priority)?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailVC.init(nibName: "DetailVC", bundle: nil)
        detailVC.didselectCellData = self.todoDatas[indexPath.row]
        detailVC.detailVCDelegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
