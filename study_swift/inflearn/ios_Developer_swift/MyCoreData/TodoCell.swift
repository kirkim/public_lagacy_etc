//
//  TodoCell.swift
//  Practice_coredata
//
//  Created by 김기림 on 2022/01/30.
//

import Foundation
import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var priorityView: UIView! {
        didSet {
            priorityView.layer.cornerRadius = priorityView.bounds.height / 2
        }
    }
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var date: UILabel!
}
