//
//  TodoListVC.swift
//  practice2_3
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit
import CoreData

class TodoListVC: UIViewController, TodoListDelegate {
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var addNewTodoButton: UIButton!
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var coreDatas = Array<TodoList>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "s"
        self.statusView?.backgroundColor = .green
        self.todoTableView.delegate = self
        self.todoTableView.dataSource = self
        let nibName = UINib(nibName: "TodoCell", bundle: nil)
        todoTableView.register(nibName, forCellReuseIdentifier: "TodoCell")
        updateCoreDatas()
    }
    
    private func updateCoreDatas() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        do {
            self.coreDatas = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        self.todoTableView.reloadData()
    }
    
    @IBAction func handleAddNewTodoButton(_ sender: UIButton) {
        let detailVC = DetailTodoVC.init(nibName: "DetailTodoVC", bundle: nil)
        detailVC.todoListDelegate = self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func didUpdateNewData() {
        self.updateCoreDatas()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension TodoListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coreDatas.count
    }
    
    private func myFormattedDate(date: Date?) -> String{
        guard let hasDate = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy - mm - dd hh:mm"
        return formatter.string(from: hasDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.todoLabel.text = self.coreDatas[indexPath.row].todo
        cell.priorityView.backgroundColor = Priority(rawValue: self.coreDatas[indexPath.row].priority)?.color
        cell.dateLabel.text = myFormattedDate(date: self.coreDatas[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailTodoVC.init(nibName: "DetailTodoVC", bundle: nil)
        detailVC.selectedCellData = self.coreDatas[indexPath.row]
        detailVC.todoListDelegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
