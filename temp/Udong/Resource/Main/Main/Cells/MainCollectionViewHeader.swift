//
//  MainCollectionViewHeader.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/06.
//

import Foundation
import SnapKit

class MainCollectionViewHeader: UICollectionReusableView {
    
    var delegate: tapMoreButton?
    let sectionNameLabel = UILabel()
    let moreButton: UIButton = {
        let buttonTextLabel = UILabel()
        let moreButton = UIButton()
        buttonTextLabel.text = "더보기"
        buttonTextLabel.font = UIFont(name: "MarkerFelt-Thin", size: 12)
        buttonTextLabel.textColor = .blue
        buttonTextLabel.textAlignment = .center
        buttonTextLabel.numberOfLines = 0
        moreButton.addSubview(buttonTextLabel)
        moreButton.addTarget(self, action: #selector(tapMore(_:)), for: .touchUpInside)
        buttonTextLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    
        return moreButton
    }()
    
    @objc private func tapMore(_ sender: Any){
        print("----------------------------")
        self.delegate?.tapMoreButton(theme: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.text = "요즘 뜨는 우리동네 식당"
        sectionNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        self.addSubview(sectionNameLabel)
        self.addSubview(moreButton)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().inset(10)
        }
        
        moreButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(50)
        }
        
    }
}

protocol tapMoreButton {
    func tapMoreButton(theme: Int)
}
