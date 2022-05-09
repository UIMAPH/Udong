//
//  RecommendItemCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/05/01.
//

import Foundation
import UIKit

class RecommendItemCollectionViewCell: UICollectionViewCell{
    var itemLabel = UILabel()
    var iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        self.displaySetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension RecommendItemCollectionViewCell{
    
    private func displaySetting(){  
        itemLabel = {
            let label = UILabel()
            label.text = ""
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        
        iconImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            return imageView
        }()

        contentView.addSubview(itemLabel)
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.height.width.equalTo(30)
        }
        itemLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
    }
}
