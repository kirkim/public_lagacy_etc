//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by 김기림 on 2021/12/13.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var pages = [UIViewController]()
    var bottomButtomMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    let STARTINDEX = 0
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    
    func makePageVC() {
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.topImage = UIImage(systemName: "person.3")
        itemVC1.mainText = "Focus on your ideal buyer"
        itemVC1.subText = "when you write a product description with a huge crowd of buters in mind, your descriptions become wishy-washy and you end up addressing no one at all"
        
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.topImage = UIImage(systemName: "tortoise.fill")
        itemVC2.mainText = "turtle"
        itemVC2.subText = "Turtles are an order of reptiles known as Testudines, characterized by a shell developed mainly from their ribs."
        
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.topImage = UIImage(systemName: "ladybug")
        itemVC3.mainText = "ladybug"
        itemVC3.subText = "It revolves around Marinette Dupain-Cheng, a Parisian teenager who transforms into Ladybug"
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        // PageViewController는 처음에 보여주는페이지를 지정해줘야한다.
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.makePageVC()
        self.makeBottomButton()
        self.makePageControl()
    }
    
    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        // 오토레이아웃 설정을하려면 아래코드가 false여야한다.
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 아래 코드가 오토레이아웃 코드
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        // 다음과 같이 safeArea를 고려해야 된다.
        bottomButtomMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtomMargin?.isActive = true
        hideButton()
    }
    
    func makePageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black // 현재 선택한 점의 색깔
        pageControl.pageIndicatorTintColor = .lightGray // 선택하지않은 점의 색깔
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = STARTINDEX
        
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // 버튼을 직접 선택하지 못하게하는 옵션
        //        pageControl.isUserInteractionEnabled = false
        
        // 버튼을 직접 선택해서 조작하게 하는 이벤트 (.valueChanged)
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        if sender.currentPage > self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        self.currentIndex = sender.currentPage // 이렇게 해야 눌렀을때도 위치가 업데이트됨
        self.buttonPresentationStyle()
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        //self.currentIndex = currentIndex
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        //self.currentIndex = currentIndex
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first else  {
            return
        }
        
        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        self.currentIndex = currentIndex
        self.buttonPresentationStyle()
    }
    
    func buttonPresentationStyle() {
        if currentIndex == pages.count - 1 {
            self.showButton()
        } else {
            self.hideButton()
        }
        
        // 애니매이션 효과주는 것
        // 방법 1
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded() // 설정시간대로 즉시 변경하겠다
//        }
        // 방법 2
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: [.curveEaseOut],
            animations: {self.view.layoutIfNeeded()}, completion: nil)
    }
    // 사람이 알아보기 쉽게 함수형식으로 재정의함
    func showButton() {
        bottomButtomMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtomMargin?.constant = 100
    }
}
