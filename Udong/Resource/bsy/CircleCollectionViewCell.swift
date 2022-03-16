//
//  circleCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/17.
//

import Foundation

class CircleCollectionViewCell: UICollectionViewCell{
    
    var imageView = UIImageView()
    
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

extension CircleCollectionViewCell{
    
    private func displaySetting(){
        
        imageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
//            let image = UIImage(named: "")
//            guard var image = image else{
//                print("image is nil")
//                return UIImageView()
//            }
//            image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 40, height: 40))!
//            imageView.image = image
            
            return imageView
        }()
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}
