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
    let nameLabel = UILabel()
    let sexLabel = UILabel()
    let ageLabel = UILabel()
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
        self.backgroundColor = .red
        [nameLabel, sexLabel, ageLabel].forEach {
            $0.textColor = .white
        }
        self.nameTag.text = "Cell 1"
        self.nameTag.backgroundColor = .darkGray
        self.nameTag.font = .systemFont(ofSize: 15)
        self.nameTag.textColor = .white
    }
    
    func setTitle(person: Person) {
        self.nameLabel.text = person.name
        self.sexLabel.text = person.sex == .male ? "남" : "여"
        self.ageLabel.text = "\(person.age)살"
    }
    
    private func layout() {
        [nameTag, nameLabel, sexLabel, ageLabel].forEach {
            self.addSubview($0)
        }
        
        nameTag.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(nameTag.snp.trailing).offset(30)
        }
        
        sexLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(25)
        }
        
        ageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
