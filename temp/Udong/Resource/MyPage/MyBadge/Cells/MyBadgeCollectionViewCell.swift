//
//  MyBadgeCollectionViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import UIKit
import SnapKit

class MyBadgeCollectionViewCell: UICollectionViewCell {
    
    var badgeImageView: UIImageView = {
        let badgeImg = UIImage(named: "sample")
        let badgeImgView = UIImageView(image: badgeImg)
        badgeImgView.layer.masksToBounds = true
        badgeImgView.layer.cornerRadius = 15
        
        return badgeImgView
    }()
    
    var badgeName: UILabel = {
        let badgeLabel = UILabel()
        badgeLabel.text = "총칼 개단골"
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return badgeLabel
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displaySetting();
    }
    
    private func displaySetting(){
        self.addSubview(badgeImageView)
        self.addSubview(badgeName)
        badgeImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.bounds.height * 0.7)
        }
        badgeName.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(badgeImageView.snp.bottom).offset(12)
        }
        
    }
    
}
