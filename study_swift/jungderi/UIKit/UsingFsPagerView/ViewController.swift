//
//  ViewController.swift
//  SlideImage
//
//  Created by 김기림 on 2022/01/05.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    fileprivate let imgNames = ["1.png", "2.png", "3.png", "4.png",]
    
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet {
            // 페이지뷰에 셀을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            // 무한스크롤 설정
            self.myPagerView.isInfinite = true
            // 자동 스크롤
            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    @IBOutlet weak var myPageController: FSPageControl! {
        didSet {
            self.myPageController.numberOfPages = self.imgNames.count
            self.myPageController.contentHorizontalAlignment = .right
            self.myPageController.itemSpacing = 16
            self.myPageController.interitemSpacing = 16
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2
    }
    
    //MARK: - IBAction
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        print("ViewController - onLeftBtnClicked() called")
        
        self.myPageController.currentPage = self.myPageController.currentPage - 1
        self.myPagerView.scrollToItem(at:         self.myPageController.currentPage, animated: true)
    }
    
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        if (self.myPageController.currentPage == self.imgNames.count - 1) {
            self.myPageController.currentPage = 0
        } else {
            self.myPageController.currentPage = self.myPageController.currentPage + 1
        }
        self.myPagerView.scrollToItem(at:         self.myPageController.currentPage, animated: true)

    }
    
    //MARK: - FSPagerViewDataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imgNames.count
    }
    
    // 각 셀에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imgNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    //MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageController.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageController.currentPage = pagerView.currentIndex
    }
    
    // 클릭시 하이라이트 없애기
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

