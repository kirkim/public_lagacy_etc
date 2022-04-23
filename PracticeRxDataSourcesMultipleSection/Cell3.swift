//
//  Cell3.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import UIKit

class Cell3: UICollectionViewCell {
    static let identifier = "Cell3"
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
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
        self.backgroundColor = .brown
        self.titleLabel.textColor = .white
        self.titleLabel.font = .systemFont(ofSize: 18)
        self.subTitleLabel.textColor = .white
        self.subTitleLabel.font = .systemFont(ofSize: 13)
        self.nameTag.text = "Cell 3"
        self.nameTag.backgroundColor = .darkGray
        self.nameTag.font = .systemFont(ofSize: 15)
        self.nameTag.textColor = .white
    }
    
    func setTitle(item: HasSubTitle) {
        self.titleLabel.text = item.title
        self.subTitleLabel.text = item.subTitle
    }
    
    private func layout() {
        [nameTag, titleLabel, subTitleLabel].forEach {
            self.addSubview($0)
        }
        
        nameTag.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
