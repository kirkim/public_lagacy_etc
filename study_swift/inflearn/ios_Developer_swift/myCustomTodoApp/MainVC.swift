//
//  ViewController.swift
//  practice2_3
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit

enum MyColor {
    case navi
    var color: UIColor {
        switch self {
        case .navi:
            return UIColor.orange
        }
    }
}

struct myFigure {
    var width: CGFloat
    var height: CGFloat
    var verticalPadding: CGFloat
    var horizontalPadding: CGFloat
}

enum ImageType {
    case titleLogo
    case barItem
    var figure: myFigure {
        switch self {
        case .titleLogo:
            return myFigure(width: 200, height: 80, verticalPadding: 10, horizontalPadding: 0)
        case .barItem:
            return myFigure(width: 40, height: 40, verticalPadding: 0, horizontalPadding: 0)
        }
    }
}

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeNavigationBar()
    }
    
    private func makeNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = MyColor.navi.color
        self.statusView?.backgroundColor = MyColor.navi.color
        let titleLogoView = UIImageView(image: makeImage(named: "pepsi", imageType: .titleLogo))
        titleLogoView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleLogoView
        let rightItem = UIBarButtonItem(image: makeImage(named: "lion", imageType: .barItem), style: .done, target: self, action: #selector(handleRightButton))
        navigationItem.rightBarButtonItems = [rightItem]
    }
    
    @objc private func handleRightButton(_ sender: UIBarButtonItem) {
        let todoListVC = TodoListVC.init(nibName: "TodoListVC", bundle: nil)

//        self.navigationController?.pushViewController(todoListVC, animated: true)
        self.navigationController?.show(todoListVC, sender: nil)
        print("hello!")
    }
    
    private func makeImage(named: String, imageType: ImageType) -> UIImage {
        let backImage = UIImage(named: named)!.withRenderingMode(.alwaysOriginal)
        let figure = imageType.figure
        let newImageRect = CGRect(x: 0, y: 0, width: figure.width - figure.horizontalPadding, height: figure.height - figure.verticalPadding)

        // 빈도화지의 크기를 만들어 그려준다는 느낌으로 다음의 코드가 동작 (한세트)
        UIGraphicsBeginImageContext(CGSize(width: figure.width, height: figure.height))
        backImage.draw(in: newImageRect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal) else { return backImage }
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIViewController {
    var statusView: UIView? {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError()
        }
        let view = sceneDelegate.statusBarView
//        self.view.addSubview(view)
        sceneDelegate.window?.addSubview(view)

        return view
    }
}
