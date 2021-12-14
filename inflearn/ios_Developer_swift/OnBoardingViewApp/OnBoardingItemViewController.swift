//
//  OnBoardingItemViewController.swift
//  OnBoardingViewApp
//
//  Created by 김기림 on 2021/12/13.
//

import UIKit

class OnBoardingItemViewController: UIViewController {
    
    var mainText = ""
    var subText = ""
    var topImage: UIImage?
    
    @IBOutlet private weak var topImageView: UIImageView!
    @IBOutlet private weak var mainTitleLabel: UILabel! {
        didSet {
            mainTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTitleLabel.text = self.mainText
        self.descriptionLabel.text = self.subText
        self.topImageView.image = self.topImage
    }
    
}
