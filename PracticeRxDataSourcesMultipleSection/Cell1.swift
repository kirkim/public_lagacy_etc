//
//  Cell1.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit
import SnapKit

class Cell1: UICollectionViewCell {
    static let identifier = "Cell1"
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .red
        self.titleLabel.textColor = .white
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func layout() {
        [titleLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
