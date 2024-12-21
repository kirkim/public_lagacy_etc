//
//  ViewController.swift
//  lecture24Prelearn
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySearchBar: UISearchBar!
    var keyHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mySearchBar.delegate = self
    }

    @IBAction func touchOutSide(_ sender: Any) {
        if (self.mySearchBar == nil) {
            return
        }
        self.mySearchBar.resignFirstResponder()
    }
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("ViewController - shouldChangeTextIn called")
        let LIMIT_LENGTH = 5
        if range.location + text.count > LIMIT_LENGTH {
            return false
        }
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("ViewController - textDidChange called")
        if (searchText.isEmpty) {
            self.mySearchBar.resignFirstResponder()
        }
        print(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("ViewController - searchBarSearchButtonClicked() called")
        self.mySearchBar.resignFirstResponder()
    }
}
