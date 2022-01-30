//
//  ViewController.swift
//  Practice_coredata
//
//  Created by 김기림 on 2022/01/30.
//

import UIKit
import CoreData

class TodoVC: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var todoLists = Array<TodoList>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadConfig()
    }
    
    @objc private func handleAddNewTodoButton(_ sender: UIBarButtonItem) {
        let addTodoListFormVC = AddTodoForm(nibName: "AddTodoForm", bundle: nil)
        addTodoListFormVC.todoListDelegate = self
        self.present(addTodoListFormVC, animated: true, completion: nil)
    }
    
    private func viewDidLoadConfig() {
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        makeNavigationBar()
        fetchData()
        self.todoTableView.reloadData()
    }
    
    private func makeNavigationBar() {
        self.title = "TodoList"
        let addNewTodoButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewTodoButton(_:)))
        navigationItem.rightBarButtonItem = addNewTodoButton
    }
    
    private func fetchData() {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        do {
            self.todoLists = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        self.todoTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TodoVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoLists.count
    }
    
    private func formattedDate(date: Date?) -> String {
        guard let hasDate = date else { return "" }
        let formmater = DateFormatter()
        formmater.dateFormat = "YYYY-MM-DD HH:MM:SS"
        return formmater.string(from: hasDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else { return TodoCell()}
        cell.goal.text = self.todoLists[indexPath.row].goal
        cell.date.text = formattedDate(date: self.todoLists[indexPath.row].date)
        cell.priorityView.backgroundColor = PriorityValue(rawValue: self.todoLists[indexPath.row].priority)?.color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let addTodoFormVC = AddTodoForm.init(nibName: "AddTodoForm", bundle: nil)
        addTodoFormVC.todoListDelegate = self
        addTodoFormVC.todoList = self.todoLists[indexPath.row]
        self.navigationController?.pushViewController(addTodoFormVC, animated: true)
    }
}

//MARK: -
extension TodoVC: TodoListDelegate {
    func didUpdateNewData() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
}
