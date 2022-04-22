//
//  BlankHeaderCell.swift
//  PracticeRxDataSourcesMultipleSection
//
//  Created by 김기림 on 2022/04/22.
//

import SnapKit
import UIKit

class BlankHeaderCell: UICollectionReusableView {
    static let identifier = "BlankHeaderCell"
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
    }
    
    private func attribute() {
        self.backgroundColor = .purple
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func layout() {
        self.addSubview(self.titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
}
