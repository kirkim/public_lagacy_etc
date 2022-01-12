//
//  ViewController.swift
//  Responsive_keyboard
//
//  Created by 김기림 on 2022/01/12.
//

import UIKit
import Toast

enum SEGUE_ID {
    static let IMAGE_COLLECTION = "ImageView"
    static let USER_LIST = "UsersView"
}

enum SearchStyle: String {
    case image
    case users
    
    var placeholder: String {
        switch rawValue {
        case "image":
            return "이미지명을 입력하세요"
        case "users":
            return "유저명을 입력하세요"
        default:
            return "이미지명을 입력하세요"
        }
    }
    
    var segueId: String {
        switch rawValue {
        case "image":
            return SEGUE_ID.IMAGE_COLLECTION
        case "users":
            return SEGUE_ID.USER_LIST
        default:
            return SEGUE_ID.IMAGE_COLLECTION
        }

    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    private var searchStyle: SearchStyle = .image {
        didSet {
            self.mySearchBar.placeholder = self.searchStyle.placeholder
        }
    }
    private var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    
    fileprivate func uiConfig() {
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.isHidden = true
        mySearchBar.placeholder = searchStyle.placeholder
        mySearchBar.returnKeyType = .done
        mySearchBar.delegate = self
        keyboardDismissTabGesture.delegate = self
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    //MARK: - Override methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("MainViewController - prepare segue called / segueID: \(segue.identifier!)")
        let nextVC: BaseVC?
        switch segue.identifier {
        case SEGUE_ID.IMAGE_COLLECTION:
            nextVC = segue.destination as! ImageCollectorVC
        case SEGUE_ID.USER_LIST:
            nextVC = segue.destination as! UserListVC
        default:
            nextVC = segue.destination as! ImageCollectorVC
        }
        
        guard let inputValue = self.mySearchBar.text else { return }
        nextVC?.vcTitle = inputValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mySearchBar.becomeFirstResponder()
    }
    
    //MARK: - IBAction methods
    @IBAction func handleMySegmentedControl(_ sender: UISegmentedControl) {
        print("MainViewController - handleMySegmentedControl() called, Index: \(sender.selectedSegmentIndex)")
        switch (sender.selectedSegmentIndex) {
        case 0:
            searchStyle = .image
        case 1:
            searchStyle = .users
        default:
            searchStyle = .image
        }
    }
    
    @IBAction func handleConfirmBtn(_ sender: UIButton) {
        if (mySearchBar.text?.count == 0) {
            self.view.makeToast("내용을 입력해주세요", duration: 1.0, position: .center)
            return
        }
        self.performSegue(withIdentifier: searchStyle.segueId, sender: self)
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text.isEmpty {
            self.view.makeToast("내용을 입력해주세요", duration: 1.0, position: .center)
        } else {
            mySearchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = range.location + text.count
        if (text != "\n" && textLength > 12) {
            self.view.makeToast("12자이내로 입력하세요", duration: 1.0, position: .center)
            return false
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            confirmBtn.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                self.mySearchBar.resignFirstResponder()
            })
        } else {
            confirmBtn.isHidden = false
        }
    }
}

//MARK: - UITapGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("MainViewController - gestureRecognizer shouldReceive() called")
        
        if (touch.view?.isDescendant(of: mySearchBar) == true) {
            print("검색바가 선택되었습니다.")
            return false
        } else if (touch.view?.isDescendant(of: mySegmentedControl) == true) {
            print("세그맨트컨트롤이 선택되었습니다")
            return false
        }
        
        mySearchBar.resignFirstResponder()
        return true
        
    }
}

//MARK: - KeyboardNotification
extension MainViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC - viewWillDisappear() called")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowHandle(_ notification: NSNotification) {
        print("MainVC - keyboardWillShowHandle() called")
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboardSize : \(keyboardSize.height)")
            print("confirmBtn : \(confirmBtn.frame.origin.y)")
            print(self.myView.frame.origin.y)
            if (keyboardSize.height > confirmBtn.frame.origin.y) {
                print("키보드가 버튼을 덮었다.")
                let distance = keyboardSize.height - confirmBtn.frame.origin.y
                print(distance)
                self.myView.frame.origin.y = distance
            }
        }
        print(self.myView.frame.origin.y)
    }
    
    @objc func keyboardWillHideHandle() {
        print("MainVC - keyboardWillHideHandle() called")
        self.myView.frame.origin.y = 240
    }
}
