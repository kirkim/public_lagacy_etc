//
//  ListViewController.swift
//  Practice12_14_1
//
//  Created by 김기림 on 2021/12/14.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate {

    var accountlist = [ "kirim", "Jane", "Mike"]

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var graduation: UISwitch!
    @IBOutlet weak var birthDate: UITextField!
    let pickerName = UIPickerView()
    let pickerBirthDate = UIPickerView()
    let year = [2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021]
    let month = [1, 2, 3 , 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let day = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
    var birth: (year: String, month: String, day: String) = (year: "0", month: "0",day: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "유저 정보"
        
        let plist = UserDefaults.standard
        self.name.text = plist.string(forKey: "name") ?? "익명"
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.graduation.isOn = plist.bool(forKey: "graduation")
        makeNamePicker()
        makeBirthDatePicker()
    }

    @objc func changeName(_ sender : Any) {
        print("hi")
        let alert = UIAlertController(title: nil, message: "이름을 입력하시오", preferredStyle: .alert)
        alert.addTextField { text in
            text.text = self.name.text
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { (_) in
            let value = alert.textFields?[0].text
            let plist = UserDefaults.standard
            plist.setValue(value, forKey: "name")
            plist.synchronize()
            
            self.name.text = value
        })
        self.present(alert, animated: true)
    }
}

extension ListViewController: UIPickerViewDataSource {
    func makeNamePicker() {
        pickerName.delegate = self
        self.name.inputView = pickerName
    }
    
    func makeBirthDatePicker() {
        pickerBirthDate.delegate = self
        self.birthDate.inputView = pickerBirthDate
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
        toolbar.barTintColor = .systemGray
        self.birthDate.inputAccessoryView = toolbar
        
        let doneButton = makeBarButton(title: "Done", actionFunc: #selector(pickerDone))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
    }
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
        self.birthDate.text = "\(birth.year) - \(birth.month) - \(birth.day)"
    }
    
    func makeBarButton(title: String, actionFunc: Selector) -> UIBarButtonItem {
        let newButton = UIBarButtonItem()
        newButton.title = title
        newButton.tintColor = .red
        newButton.target = self
        newButton.action = actionFunc
        
        return newButton
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerName {
            return 1
        } else if pickerView == pickerBirthDate {
            return 3
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerName {
            return self.accountlist.count
        } else if pickerView == pickerBirthDate {
            switch component {
            case 0:
                return self.year.count
            case 1:
                return self.month.count
            case 2:
                return self.day.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func formatInttoString(intArray: [Int]) -> [String] {
        return intArray.map { String($0)}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerName {
            return self.accountlist[row]
        } else if pickerView == pickerBirthDate {
            switch component {
            case 0:
                return formatInttoString(intArray: self.year)[row]
            case 1:
                return formatInttoString(intArray: self.month)[row]
            case 2:
                return formatInttoString(intArray: self.day)[row]
            default:
                return nil
            }
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerName {
            self.name.text = self.accountlist[row]
        } else if pickerView == pickerBirthDate {
            switch component {
            case 0:
                self.birth.year = String(self.year[row])
            case 1:
                self.birth.month = String(self.month[row])
            case 2:
                self.birth.day = String(self.day[row])
            default:
                print("error")
            }
        }
    }
}

