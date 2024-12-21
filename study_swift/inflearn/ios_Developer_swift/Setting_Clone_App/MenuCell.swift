//
//  MenuCell.swift
//  Setting_Clone_App
//
//  Created by 김기림 on 2021/12/09.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var middleTitle: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
