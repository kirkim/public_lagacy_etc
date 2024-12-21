//
//  DetailMovieVC.swift
//  MyMovieApp
//
//  Created by 김기림 on 2022/01/26.
//

import UIKit
import AVKit

class DetailMovieVC: UIViewController {
    
    var resultData: MovieResult?
    
    @IBOutlet private weak var movieContainer: UIView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            dateLabel.textColor = .white
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }

    private func config() {
        titleLabel.text = resultData?.title
        let dateString = resultData?.date ?? ""
        dateLabel.text = getFormattedDate(dateString)
        descriptionLabel.text = resultData?.longDescription
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let preViewUrl = resultData?.previewUrl ?? ""
        makePlayerAndPlay(urlString: preViewUrl)

    }
    
    private func getFormattedDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let isoDate = formatter.date(from: dateString) else { return "" }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy년 MM월 dd일"
        let resultDate = myFormatter.string(from: isoDate)
        
        return resultDate
    }
    
    private func makePlayerAndPlay(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = movieContainer.bounds
        movieContainer.layer.addSublayer(playerLayer)
        player.play()
    }
}
