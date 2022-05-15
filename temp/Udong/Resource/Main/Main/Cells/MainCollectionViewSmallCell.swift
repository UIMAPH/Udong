//
//  MainCollectionViewSmallCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/05.
//

import UIKit
import SnapKit

class MainCollectionViewSmallCell: UICollectionViewCell {
   
    var storeInfo: NetkResponse<DataClass>?
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = self.storeInfo?.data?.storeName ?? "Error"
        titleLabel.textAlignment = .left
        
        return titleLabel
    }()
    lazy var mainblueView: UIView = {
        let mainblueView = UIView()
        mainblueView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
        mainblueView.backgroundColor = .mainblue
        
        return mainblueView
    }()
    lazy var storeImageView: UIImageView = {
//        let url = URL(string: storeInfo?.data)
//        let data = try? Data(contentsOf: url!)
//        let storeImage = UIImage(data: data ?? Data())
        let storeImage = UIImage(named: "sample")
        let storeImageView = UIImageView(image: storeImage)
        storeImageView.contentMode = .scaleToFill
        
        return storeImageView
    }()
    
    override func layoutSubviews(){
        self.addSubview(mainblueView)
        self.addSubview(storeImageView)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        mainblueView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        storeImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mainblueView.snp.top)
        }
    }
}
