//
//  TodoCell.swift
//  practice2_3
//
//  Created by 김기림 on 2022/02/03.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var priorityView: UIView! {
        didSet {
            priorityView.layer.cornerRadius = priorityView.bounds.height / 2
        }
    }
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
