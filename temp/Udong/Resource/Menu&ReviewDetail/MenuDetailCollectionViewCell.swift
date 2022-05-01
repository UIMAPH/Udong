//
//  MenuCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/27.
//

import Foundation

class MenuDetailCollectionViewCell: UICollectionViewCell{
    
    var menu = UILabel()
    var price = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.displaySetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MenuDetailCollectionViewCell{
    
    private func displaySetting(){
        
        menu = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(16)
            return label
        }()
        
        price = {
            let label = UILabel()
            label.text = ""
            label.textColor = .systemBlue
            label.font = label.font.withSize(16)
            return label
        }()
        
        imageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            imageView.backgroundColor = .lightGray
            return imageView
        }()

        contentView.addSubview(menu)
        contentView.addSubview(price)
        contentView.addSubview(imageView)
        
        menu.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        price.snp.makeConstraints{
            $0.top.equalTo(menu.snp.bottom).offset(10)
            $0.leading.equalTo(menu)
        }
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.width.equalTo(70)
        }
        
    }
}
