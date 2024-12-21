//
//  SampleHeaderCell.swift
//  MagnetBarView
//
//  Created by 김기림 on 2022/04/18.
//

import SnapKit
import UIKit

class MagnetMenuHeaderCell: UICollectionReusableView {
    static let identifier = "MagnetMenuHeaderCell"
    private let nameTag = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String) {
        self.titleLabel.text = title
        self.nameTag.text = "Header 1"
        self.nameTag.textColor = .white
        self.nameTag.backgroundColor = .black
    }
    
    private func attribute() {
        self.backgroundColor = .gray
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func layout() {
        [nameTag, titleLabel].forEach {
            self.addSubview($0)
        }
        nameTag.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameTag.snp.trailing).offset(50)
        }
    }
}
