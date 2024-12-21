//
//  AddTodoForm.swift
//  Practice_coredata
//
//  Created by 김기림 on 2022/01/30.
//

import UIKit
import CoreData

enum PriorityValue: Int64 {
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

protocol TodoListDelegate {
    func didUpdateNewData()
}

class AddTodoForm: UIViewController {

    @IBOutlet weak var TextFieldForGoal: UITextField!
    
    @IBOutlet weak var lowBtn: priorityButton!
    @IBOutlet weak var normalBtn: priorityButton!
    @IBOutlet weak var highBtn: priorityButton!
    @IBOutlet weak var saveBtn: selectButton!
    @IBOutlet weak var deleteBtn: selectButton!
        
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var todoListDelegate: TodoListDelegate?
    private var priority: PriorityValue?
    var todoList: TodoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = self.todoList {
            TextFieldForGoal.text = hasData.goal
            priority = PriorityValue(rawValue: hasData.priority)
            updatePriorityColor()
            saveBtn.setTitle("Update", for: .normal)
        } else {
            saveBtn.setTitle("Save", for: .normal)
            deleteBtn.isHidden = true
        }
    }

    @IBAction func handlePriorityBtn(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .low
        case 2:
            priority = .normal
        case 3:
            priority = .high
        default:
            priority = .low
        }
        updatePriorityColor()
    }
    
    private func updatePriorityColor() {
        self.lowBtn.backgroundColor = .clear
        self.normalBtn.backgroundColor = .clear
        self.highBtn.backgroundColor = .clear
        
        switch self.priority {
        case .low:
            self.lowBtn.backgroundColor = PriorityValue.low.color
        case .normal:
            self.normalBtn.backgroundColor = PriorityValue.normal.color
        case .high:
            self.highBtn.backgroundColor = PriorityValue.high.color
        default:
            self.lowBtn.backgroundColor = PriorityValue.low.color
        }
    }
    
    
    //MARK: - handle Save, Update, Delete button
    private func saveData() {
        let context = appDelegate.persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context),
              let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        object.goal = TextFieldForGoal.text
        object.date = Date()
        object.id = UUID()
        object.priority = self.priority?.rawValue ?? PriorityValue.low.rawValue
        self.todoListDelegate?.didUpdateNewData()
        appDelegate.saveContext()
        todoListDelegate?.didUpdateNewData()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateData() {
        guard let id = todoList?.id else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            loadedData.first?.goal = TextFieldForGoal.text
            loadedData.first?.priority = self.priority?.rawValue ?? PriorityValue.low.rawValue
        } catch {
            print(error)
        }
        appDelegate.saveContext()
        todoListDelegate?.didUpdateNewData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleComfimButton(_ sender: UIButton) {
        if todoList == nil {
            saveData()
        } else {
            updateData()
        }
    }
    
    
    
    @IBAction func handleDeleteButton(_ sender: UIButton) {
        guard let id = todoList?.id else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appDelegate.persistentContainer.viewContext
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
