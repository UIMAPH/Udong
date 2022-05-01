//
//  TierInfoCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/29.
//

import Foundation

class TierInfoCollectionViewCell: UICollectionViewCell{
    
    var tierNmae = UILabel()
    var info = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        self.displaySetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension TierInfoCollectionViewCell{
    
    private func displaySetting(){
        
        tierNmae = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(20)
            return label
        }()
        
        info = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(15)
            return label
        }()
        
        imageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            //imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 30
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = imageView.frame.height/2
            imageView.layer.borderWidth = 3
            return imageView
        }()

        contentView.addSubview(tierNmae)
        contentView.addSubview(info)
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(60)
        }
        tierNmae.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-12)
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
        }
        info.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(12)
            $0.leading.equalTo(tierNmae)
        }
        
    }
}
