//
//  DetailTodoVC.swift
//  practice2_3
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit
import CoreData

enum Priority: Int64 {
    case low
    case normal
    case high
    var color: UIColor {
        switch self {
        case .low:
            return UIColor.green
        case .normal:
            return UIColor.yellow
        case  .high:
            return UIColor.red
        }
    }
}

protocol  TodoListDelegate {
    func didUpdateNewData()
}


class DetailTodoVC: UIViewController {

    @IBOutlet weak var textFieldForTodo: UITextField!
    @IBOutlet weak var lowPriorityButton: UIButton!
    @IBOutlet weak var normalPriorityButton: UIButton!
    @IBOutlet weak var highPriorityButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var todoListDelegate: TodoListDelegate?
    var selectedCellData: TodoList?
    private var priority: Priority? {
        didSet {
            updatePriorityButtonBackgroundColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.selectedCellData == nil {
            self.confirmButton.setTitle("Save", for: .normal)
            self.deleteButton.isHidden = true
        } else {
            self.textFieldForTodo.text = self.selectedCellData?.todo
            self.priority = Priority(rawValue: self.selectedCellData?.priority ?? Priority.low.rawValue)
            self.confirmButton.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func handlePriorityButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            priority = Priority.low
        case 1:
            priority = Priority.normal
        case 2:
            priority = Priority.high
        default:
            priority = Priority.low
        }
    }
    
    private func updatePriorityButtonBackgroundColor() {
        self.lowPriorityButton.backgroundColor = .clear
        self.normalPriorityButton.backgroundColor = .clear
        self.highPriorityButton.backgroundColor = .clear
        
        switch self.priority {
        case .low:
            self.lowPriorityButton.backgroundColor = Priority.low.color
        case .normal:
            self.normalPriorityButton.backgroundColor = Priority.normal.color
        case .high:
            self.highPriorityButton.backgroundColor = Priority.high.color
        default:
            self.lowPriorityButton.backgroundColor = Priority.low.color
            
        }
    }
    
    private func saveData() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context),
              let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        object.todo = textFieldForTodo.text
        object.date = Date()
        object.id = UUID()
        object.priority = self.priority?.rawValue ?? Priority.low.rawValue
        appDelegate.saveContext()
        todoListDelegate?.didUpdateNewData()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateData() {
        guard let id = selectedCellData?.id else { return }
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            loadedData.first?.todo = self.textFieldForTodo.text
            loadedData.first?.priority = self.priority?.rawValue ?? Priority.low.rawValue
        } catch {
            print(error)
        }
        appDelegate.saveContext()
        todoListDelegate?.didUpdateNewData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleConfimButton(_ sender: UIButton) {
        if selectedCellData == nil {
            saveData()
        } else {
            updateData()
        }
    }
    
    @IBAction func handleDeleteButton(_ sender: UIButton) {
        guard let id = selectedCellData?.id else { return }
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            guard let hasData = loadedData.first else { return }
            context.delete(hasData)
        } catch {
            print(error)
        }
        appDelegate.saveContext()
        todoListDelegate?.didUpdateNewData()
        self.navigationController?.popViewController(animated: true)
    }
}
