//
//  MainCollectionViewLongCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/06.
//

import Foundation

class MainCollectionViewLongCell: UICollectionViewCell {
    
    var storeInfo: StoreInfo?
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = self.storeInfo?.data?.storeName ?? "Error"
        titleLabel.textAlignment = .left
        
        return titleLabel
    }()
    
    lazy var storeImageView: UIImageView = {
//        let url = URL(string: storeInfo?.data)
//        let data = try? Data(contentsOf: url!)
//        let storeImage = UIImage(data: data ?? Data())
        let storeImage = UIImage(named: "sample")
        let storeImageView = UIImageView(image: storeImage)
        storeImageView.contentMode = .scaleAspectFill
        storeImageView.layer.cornerRadius = 15
        storeImageView.layer.masksToBounds = true
        
        return storeImageView
    }()
    
    override func layoutSubviews(){
        self.backgroundColor = .mainblue
        self.addSubview(titleLabel)
        self.addSubview(storeImageView)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        storeImageView.snp.makeConstraints{
            $0.top.bottom.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalTo(storeImageView.snp.leading)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
        }
        
    }
}
