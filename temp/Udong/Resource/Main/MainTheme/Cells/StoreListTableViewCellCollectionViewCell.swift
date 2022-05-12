//
//  StoreListTableViewCellCollectionViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/28.
//

import UIKit
import SnapKit

class StoreListTableViewCellCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let image = UIImage(named: "sample")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}
