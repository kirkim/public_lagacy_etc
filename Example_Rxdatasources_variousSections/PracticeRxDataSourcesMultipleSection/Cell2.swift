//
//  Cell2.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit

class Cell2: UICollectionViewCell {
    static let identifier = "Cell2"
    let titleLabel = UILabel()
    let nameTag = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.backgroundColor = .blue
        self.titleLabel.textColor = .white
        self.nameTag.text = "Cell 2"
        self.nameTag.backgroundColor = .darkGray
        self.nameTag.font = .systemFont(ofSize: 15)
        self.nameTag.textColor = .white
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func layout() {
        [nameTag, titleLabel].forEach {
            self.addSubview($0)
        }
        
        nameTag.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
