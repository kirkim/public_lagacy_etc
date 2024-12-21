//
//  TableCell.swift
//  Practice_closure_delegate
//
//  Created by 김기림 on 2022/01/21.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var tempView: UIView! {
        didSet {
            tempView.backgroundColor = UIColor.yellow
            tempView.layer.borderColor = UIColor.black.cgColor
            tempView.layer.borderWidth = 1
            tempView.layer.cornerRadius = 8
            tempView.clipsToBounds = true
        }
    }
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        }
    }
    @IBOutlet weak var ageLabel: UILabel! {
        didSet {
            ageLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        }
    }
    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            genderLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        }
    }
}
