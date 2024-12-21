//
//  ViewController.swift
//  MyAddMobTest
//
//  Created by 김기림 on 2022/01/03.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In this case, we instantiate the banner with desired ad size.
        // 배너의 사이즈를 설정
        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
        
//        // 하단에 배너뷰를 추가 ==> 배너뷰가 받고난뒤 로드되는게 좋기 때문에 해당 델리게이트 함수로 옮겨줌
//        addBannerViewToView(bannerView)
        
        
        // 광고 배너의 아이디를 설정
        bannerView.adUnitID = "ca-app-pub-7828371634863384/6277148096"
        bannerView.rootViewController = self
        
        // 광고를 로드한다.
        bannerView.load(GADRequest())
        
        // 델리겟을 배너뷰에 연결
        bannerView.delegate = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        // 오토레이아웃으로 뷰를 설정
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        // 루트뷰에 배너를 추가
        view.addSubview(bannerView)
        // 앵커를 설정하여 오토레이아웃 설정
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    //MARK: -  GADBannerViewDelegate 메소드
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        // 하단에 배너뷰를 추가
        addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

