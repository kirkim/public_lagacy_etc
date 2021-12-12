//
//  ProfileCell.swift
//  Practice12_10_1
//
//  Created by 김기림 on 2021/12/11.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mainTitle.textColor = .blue
        self.mainTitle.font = UIFont.systemFont(ofSize: 20)
        
        self.subTitle.textColor = .gray
        self.subTitle.font = UIFont.systemFont(ofSize: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
