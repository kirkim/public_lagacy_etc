//
//  ViewController.swift
//  UsingToastApi
//
//  Created by 김기림 on 2022/01/07.
//

import UIKit
import Toast

enum SEGUE_ID {
    static let PHOTO_COLLECTION_VC = "goToImageVC"
    static let USER_LIST_VC = "goToProfileVC"
}

enum SegmentedMenu: String {
    
    case image = "사진 키워드"
    case profile = "사용자 이름"
    
    /* segue ID를 설정*/
    var segueID: String {
        switch self {
        case .image:
            return SEGUE_ID.PHOTO_COLLECTION_VC
        case .profile:
            return SEGUE_ID.USER_LIST_VC
        }
    }
}

class MainVC: UIViewController {

    @IBOutlet weak var mySearchSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedSegmented: SegmentedMenu = .image
    var keyboardDismissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    
    //MARK: - override function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui 설정
        self.config()

        // 제스처 추가
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("MainVC - viewDidAppear() called")
        self.searchBar.becomeFirstResponder() // 포커싱 주기
    }
    
    // 화면이 넘어가기 전에 준비한다
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("MainVC - prepare() called / segue.identifier: \(segue.identifier)")
        
        switch segue.identifier {
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            print("sd")
        case SEGUE_ID.USER_LIST_VC:
            let nextVC = segue.destination as! UserListVC
            guard let userInputValue = self.searchBar.text else { return }
            nextVC.vcTitle = userInputValue + "🧑‍💻"
        default:
            print("default")
        }
    }
    
    fileprivate func config() {
        searchBtn.layer.cornerRadius = 20
        searchBar.layer.cornerRadius = 20
        searchBar.placeholder = "\(selectedSegmented.rawValue) 입력"
        searchBar.returnKeyType = .done
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        keyboardDismissTabGesture.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainVC - viewWillAppear() called")
        // 키보드 올라가는 이벤트를 받는 처리
        // 키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 키보드 노티 해제
        print("MainVC - viewWillDisappear() called")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShowHandle(notification: NSNotification) {
        print("HomeVC - keyboardWillShowHandle() called")
        // 키보드 사이즈 가져오기
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboardSize.height: \(keyboardSize.height)")
            print("searchButton.frame.origin.y: \(searchBtn.frame.origin.y)")
            
            if (keyboardSize.height < searchBtn.frame.origin.y) {
                print("키보드가 버튼을 덮었다.")
                let distance = keyboardSize.height - searchBtn.frame.origin.y
                print(distance - searchBtn.frame.height)
                self.view.frame.origin.y = distance - searchBtn.frame.height
            }
        }
    }
    
    @objc func keyboardWillHide() {
        print("HomeVC - keyboardWillHide() called")
        self.view.frame.origin.y = 0
    }
    
    //MARK: - IBAction function
    @IBAction func chooseSegmented(_ sender: UISegmentedControl) {
        print("MainVC - chooseSegmented called Index: ",
              sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegmented = .image
        case 1:
            selectedSegmented = .profile
        default:
            selectedSegmented = .image
        }
        searchBar.placeholder = "\(selectedSegmented.rawValue) 입력"
    }
    
    @IBAction func handleSearchBtn(_ sender: Any) {
        print("MainVC - handleSearchBtn called")
        self.performSegue(withIdentifier: selectedSegmented.segueID, sender: self)
    }
}

// MARK: - UISearchBarDelegate
extension MainVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print("MainVC - searchBar shouldChangeTextIn() called")
        let LIMIT_INPUT: Int = 15
        
        if (text.count + range.location > LIMIT_INPUT) {
            print("over LIMIT_INPUT")
            self.view.makeToast("📢 15자 까지만 입력가능합니다", duration: 2.0, position: .center)
            return false
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("MainVC - searchBar textDidChange() called")
//        self.searchBtn.isHidden = searchText.isEmpty ? true : false
        
        if (searchText.isEmpty == true) {
            self.searchBtn.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                searchBar.resignFirstResponder()
            })
        } else {
            self.searchBtn.isHidden = false
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("MainVC - searchBarSearchButtonClicked() called")
        
        guard let text = searchBar.text else { return }
        
        if text.isEmpty {
            self.view.makeToast("📣 검색 키워드를 입력해주세요", duration: 2.0, position: .center)
        } else {
            self.performSegue(withIdentifier: selectedSegmented.segueID, sender: self)
            self.searchBar.resignFirstResponder()
        }
        print(text)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension MainVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print("MainVC - gestureRecognizer shouldReceive() called")
        
        // 터치로 들어온 뷰가 요놈이면
        if(touch.view?.isDescendant(of: mySearchSegmentedControl) == true) {
            print("세그멘트가 터치")
            return false
        } else if (touch.view?.isDescendant(of: searchBar) == true) {
            print("서치바가 터치")
            return false
        }
        print("화면이 터치")
        view.endEditing(true)
        
        return true
    }
}
