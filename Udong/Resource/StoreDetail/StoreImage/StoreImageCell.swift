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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension StoreImageCell{
    
    private func displaySetting(){
        
        storeImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            //imageView.contentMode = .scaleAspectFill
            return imageView
        }()

        contentView.addSubview(storeImageView)
        storeImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
