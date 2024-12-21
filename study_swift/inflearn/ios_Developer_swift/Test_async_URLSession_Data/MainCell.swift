//
//  MainCell.swift
//  practiceURLSession
//
//  Created by 김기림 on 2022/01/19.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet weak var indexCnt: UILabel! {
        didSet {
            indexCnt.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            genderLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        }
    }
}
