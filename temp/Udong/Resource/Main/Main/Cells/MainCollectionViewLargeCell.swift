//
//  MainCollectionViewLargeCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/05.
//

import UIKit
import SnapKit
import UIKit

class MainCollectionViewLargeCell: UICollectionViewCell {
    
    var storeInfo: NetkResponse<DataClass>?
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = self.storeInfo?.data?.storeName ?? "Error"
        titleLabel.textAlignment = .left
        
        return titleLabel
    }()
    
    lazy var customLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.font = .systemFont(ofSize: 12)
        customLabel.text = "\(String(describing: self.storeInfo?.data?.visitCount ?? 100))명의 단골" 
        customLabel.textAlignment = .left
        
        return customLabel
    }()
    
    lazy var mainblueView: UIView = {
        let mainblueView = UIView()
        mainblueView.addSubview(self.titleLabel)
        mainblueView.addSubview(self.customLabel)
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
        }
        customLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(10)
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
            $0.height.equalTo(80)
        }
        
        storeImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mainblueView.snp.top)
        }
    }
    
}
