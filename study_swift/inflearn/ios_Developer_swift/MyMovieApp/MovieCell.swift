//
//  MovieCell.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/18.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            self.dateLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            self.descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)

        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            self.priceLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        }
    }
}
