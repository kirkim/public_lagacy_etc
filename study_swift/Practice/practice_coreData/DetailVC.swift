//
//  DetailVC.swift
//  Practice_datacore2
//
//  Created by 김기림 on 2022/02/01.
//

import UIKit
import CoreData

protocol DetailVCDelegate: AnyObject {
    func updateDataCompletion()
}

class DetailVC: UIViewController {
    @IBOutlet weak var textFieldForTodo: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var detailVCDelegate: DetailVCDelegate?
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var didselectCellData: TodoList?
    var priorityValue: PriorityValue? {
        didSet {
            self.updatePriorityButtonBackgroudColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.didselectCellData == nil {
            self.confirmButton.setTitle("Save", for: .normal)
            self.deleteButton.isHidden = true
        } else {
            self.confirmButton.setTitle("Update", for: .normal)
            self.textFieldForTodo.text = self.didselectCellData?.todo
            self.priorityValue = PriorityValue(rawValue: self.didselectCellData?.priority ?? PriorityValue.low.rawValue)
        }
    }
    
    @IBAction func handlePriorityButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.priorityValue = .low
        case 1:
            self.priorityValue = .normal
        case 2:
            self.priorityValue = .high
        default:
            self.priorityValue = .low
        }
    }
    
    private func updatePriorityButtonBackgroudColor() {
        self.lowButton.backgroundColor = .clear
        self.normalButton.backgroundColor = .clear
        self.highButton.backgroundColor = .clear
        
        switch self.priorityValue {
        case .low:
            self.lowButton.backgroundColor = PriorityValue.low.color
        case .normal:
            self.normalButton.backgroundColor = PriorityValue.normal.color
        case .high:
            self.highButton.backgroundColor = PriorityValue.high.color
        default:
            self.lowButton.backgroundColor = PriorityValue.low.color
        }
    }
    
    @IBAction func handleConfimButton(_ sender: UIButton) {
        if self.didselectCellData == nil {
            saveData()
        } else {
            updateData()
        }
    }
    
    private func saveData() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: context),
              let object = NSManagedObject(entity: entityDescription, insertInto: context) as? TodoList else { return }
        object.todo = textFieldForTodo.text
        object.date = Date()
        object.id = UUID()
        object.priority = self.priorityValue?.rawValue ?? PriorityValue.low.rawValue
        appdelegate.saveContext()
        detailVCDelegate?.updateDataCompletion()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateData() {
        guard let id = didselectCellData?.id else { return }
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let hasData = try context.fetch(fetchRequest)
            hasData.first?.todo = self.textFieldForTodo.text
            hasData.first?.priority = self.priorityValue?.rawValue ?? PriorityValue.low.rawValue
        } catch {
            print(error)
        }
        appdelegate.saveContext()
        self.detailVCDelegate?.updateDataCompletion()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleDeleteButton(_ sender: UIButton) {
        guard let id = didselectCellData?.id else { return }
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let hasData = try context.fetch(fetchRequest)
            guard let targetData = hasData.first else { return }
            context.delete(targetData)
        } catch {
            print(error)
        }
        appdelegate.saveContext()
        self.detailVCDelegate?.updateDataCompletion()
        self.navigationController?.popViewController(animated: true)

    }
}
