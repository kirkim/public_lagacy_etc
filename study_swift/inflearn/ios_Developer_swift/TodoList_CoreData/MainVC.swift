//
//  ViewController.swift
//  MyTodoList
//
//  Created by 김기림 on 2022/01/28.
//

import UIKit
import CoreData

enum MyError: String, Error {
    case dateFail = "fail formatting date"
}

enum PriorityLevel: Int64 {
    case level1
    case level2
    case level3
}
extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}

class MainVC: UIViewController {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var todoLists = [TodoList]()
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.delegate = self
        todoTableView.dataSource = self
        makeNavigationBar()
        fetchData()
        todoTableView.reloadData()
    }
    
    private func fetchData() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            self.todoLists = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    private func makeNavigationBar() {
        self.title = "Todo List"
        let addBtnItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        addBtnItem.tintColor = .white
        navigationItem.rightBarButtonItem = addBtnItem
        
        let MyBarAppearance = UINavigationBarAppearance()
        MyBarAppearance.backgroundColor = .green.withAlphaComponent(0.6)
        self.navigationController?.navigationBar.scrollEdgeAppearance = MyBarAppearance
        self.navigationController?.navigationBar.standardAppearance = MyBarAppearance
//        self.navigationController?.navigationBar.compactAppearance = MyBarAppearance
    }
    
    @objc func addNewTodo() {
        let addFormVC = AddNewTodoFormVC.init(nibName: "AddNewTodoFormVC", bundle:  nil)
        addFormVC.addNewTodoFormDelegate = self
        self.present(addFormVC, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoLists.count
    }
    
    func formatDate(date: Date?) -> String {
        guard let date = date else {
            print("Error: ", MyError.dateFail.rawValue)
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd hh:mm:ss"
        return formatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = todoTableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else { return TodoCell() }
        cell.titleLabel.text = todoLists[indexPath.row].title
        cell.dateLabel.text = formatDate(date: todoLists[indexPath.row].date)
        let priority = todoLists[indexPath.row].priorityLevel
        cell.priorityView.backgroundColor = PriorityLevel(rawValue: priority)?.color
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AddNewTodoFormVC.init(nibName: "AddNewTodoFormVC", bundle: nil)
        detailVC.addNewTodoFormDelegate = self
        detailVC.selectedList = self.todoLists[indexPath.row]
        present(detailVC, animated: true, completion: nil)
    }
}

//MARK: - AddNewToDoFormDelegate
extension MainVC: AddNewTodoFormDelegate {
    func updateTodoList() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
}
