//
//  TodoCell.swift
//  Practice_datacore2
//
//  Created by 김기림 on 2022/02/01.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var priorityView: UIView! {
        didSet {
            priorityView.layer.cornerRadius = priorityView.bounds.height / 2
        }
    }
    @IBOutlet weak var todo: UILabel!
    @IBOutlet weak var date: UILabel!
}
