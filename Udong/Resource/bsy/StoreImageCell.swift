//
//  PhotoCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/09.
//

import Foundation
import UIKit

class StoreImageCell: UICollectionViewCell{
    
    var storeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.displaySetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.displaySetting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.displaySetting()
    }
}

extension StoreImageCell{
    
    private func displaySetting(){
        
        storeImageView = {
            let storeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//            let storeImage = UIImage(named: "rectangle.png")  // 기본이미지 설정
//            guard var storeImage = storeImage else{
//                print("store image is nil")
//                return UIImageView()
//            }
//            storeImage = StoreDetailViewController().resizeImage(image: storeImage, targetSize: CGSize(width: 100, height: 100))!
//            storeImageView.image = storeImage

            return storeImageView
        }()

        contentView.addSubview(storeImageView)
        storeImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
