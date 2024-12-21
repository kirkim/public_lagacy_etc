//
//  addNewTodoFormVC.swift
//  MyTodoList
//
//  Created by 김기림 on 2022/01/28.
//

import UIKit
import CoreData

protocol AddNewTodoFormDelegate: AnyObject {
    func updateTodoList()
}

class AddNewTodoFormVC: UIViewController {

    weak var addNewTodoFormDelegate: AddNewTodoFormDelegate?
    private var priorityLevel: PriorityLevel?
    var selectedList: TodoList?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var highBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowBtn.layer.cornerRadius = 20
        mediumBtn.layer.cornerRadius = 20
        highBtn.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = selectedList {
            titleTextField.text = hasData.title
            priorityLevel = PriorityLevel(rawValue: hasData.priorityLevel)
            updatePriorityBtnDesign()
            saveBtn.setTitle("Update", for: .normal)
        } else {
            saveBtn.setTitle("Save", for: .normal)
            deleteBtn.isHidden = true
        }
    }
    
    @IBAction func handlePriorityBtn(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priorityLevel = .level1
        case 2:
            priorityLevel = .level2
        case 3:
            priorityLevel = .level3
        default:
            priorityLevel = .level1
        }
        updatePriorityBtnDesign()
    }
    
    func updatePriorityBtnDesign() {
        lowBtn.backgroundColor = .clear
        mediumBtn.backgroundColor = .clear
        highBtn.backgroundColor = .clear
        
        switch priorityLevel {
        case .level1:
            lowBtn.backgroundColor = PriorityLevel.level1.color
        case .level2:
            mediumBtn.backgroundColor = PriorityLevel.level2.color
        case .level3:
            highBtn.backgroundColor = PriorityLevel.level3.color
        default:
            lowBtn.backgroundColor = PriorityLevel.level1.color
        }
    }
    
    @IBAction func handleSaveBtn(_ sender: UIButton) {
        if self.selectedList == nil {
            saveData()
        } else {
            updateData()
        }
        appDelegate.saveContext()
        addNewTodoFormDelegate?.updateTodoList()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveData() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context),
              let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        object.title = titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        object.priorityLevel = priorityLevel?.rawValue ?? PriorityLevel.level1.rawValue
    }
    
    private func updateData() {
        guard let uuid = selectedList?.uuid else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.priorityLevel = self.priorityLevel?.rawValue ?? PriorityLevel.level1.rawValue
        } catch {
            print(error)
        }
    }
    
    @IBAction func deleteData(_ sender: UIButton) {
        guard let uuid = selectedList?.uuid else { return }
        let fetchRequest : NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", uuid as CVarArg)
        do {
            let loadedData = try context.fetch(fetchRequest)
            guard let hasData = loadedData.first else { return }
            context.delete(hasData)
            appDelegate.saveContext()
        } catch {
            print(error)
        }
        addNewTodoFormDelegate?.updateTodoList()
        self.dismiss(animated: true, completion: nil)
    }
}
