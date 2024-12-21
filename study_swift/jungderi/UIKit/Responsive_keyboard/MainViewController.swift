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

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    private var MYVIEW_Y: CGFloat?
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
        MYVIEW_Y = myView.frame.origin.y
        configureStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mySearchBar.becomeFirstResponder()
//        self.view.frame.origin.y = -150
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
            self.myView.makeToast("내용을 입력해주세요", duration: 1.0, position: .center)
        } else {
            mySearchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = range.location + text.count
        if (text != "\n" && textLength > 12) {
            self.myView.makeToast("12자이내로 입력하세요", duration: 1.0, position: .center)
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
//        print("MainViewController - gestureRecognizer shouldReceive() called")
        
        if (touch.view?.isDescendant(of: mySearchBar) == true) {
//            print("검색바가 선택되었습니다.")
            return false
        } else if (touch.view?.isDescendant(of: mySegmentedControl) == true) {
//            print("세그맨트컨트롤이 선택되었습니다")
            return false
        }
        view.endEditing(true)
//        mySearchBar.resignFirstResponder()
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
        //            print("keyboardSize : \(keyboardSize.height)")
        //            print("Screen: ", UIScreen.main.bounds.height)
        //            print(self.myView.frame.origin.y)
        //            print(self.myView.frame.height)
        //            print("UIScreenHeight: ", UIScreen.main.bounds.height)
        //            print("keyboardSize: ", keyboardSize.height)
        //            print("-----frame-----")
        //            print("btnHeight: ", confirmBtn.frame.height)
        //            print("btnY: ", confirmBtn.frame.origin.y)
        //            print("-----myViews-----")
        //            print("myViewY: ", myView.frame.origin.y)
        //            print("-----scrollview-----")
        //            print("offset: ", myScrollView.contentOffset.y)
        //            print("frameY: ", myScrollView.frame.origin.y)
        //            let navBar = self.navigationController!.navigationBar
        //            print("navBarHeight: ", navBar.bounds.height)
        //            print("navBarY: ", navBar.frame.origin.y)
        //            print("navi:", navBar.frame)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let distance = keyboardSize.height - (UIScreen.main.bounds.height - self.myView.frame.origin.y - self.myView.frame.height - self.myScrollView.frame.origin.y + self.myScrollView.contentOffset.y)
            self.myView.frame.origin.y -= distance
    
//            let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
//            let screen = UIScreen.main.bounds.height - keyboardSize.height
//            let aa = screen - (confirmBtn.frame.origin.y + myView.frame.origin.y + myScrollView.frame.origin.y - myScrollView.contentOffset.y + 35)
//            print("screen: ", screen)
//            print("aa: ", aa)
//            if (self.view.frame.origin.y == 0) {
//                self.view.frame.origin.y += aa
//            }
        }
//        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHideHandle() {
        print("MainVC - keyboardWillHideHandle() called")
        self.myView.frame.origin.y = MYVIEW_Y ?? 0
        self.view.frame.origin.y = 0
    }
}

extension MainViewController {
    private func configureStackView() {
            for _ in 0..<10 {
                let dummyView = randomColoredView()
                myStackView.addArrangedSubview(dummyView)
            }
        }

        // 랜덤 색상, 100~400 height를 가진 뷰 생성 함수
        private func randomColoredView() -> UIView {
            let view = UIView()
            view.backgroundColor = UIColor(
                displayP3Red: 1.0,
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: .random(in: 0...1))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: .random(in: 100...400)).isActive = true
            return view
        }
}
