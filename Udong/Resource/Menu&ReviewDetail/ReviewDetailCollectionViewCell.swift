//
//  ReviewCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/28.
//

import Foundation

class ReviewDetailCollectionViewCell: UICollectionViewCell{
    
    var content = UILabel()
    var writer = UILabel()
    var date = UILabel()
    var visitCount = UILabel()
    var heartImageView = UIImageView()
    var likeCount = UILabel()
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

extension ReviewDetailCollectionViewCell{
    
    private func displaySetting(){
        
        content = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(16)
            return label
        }()
        
        writer = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(14)
            return label
        }()
        
        date = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(14)
            return label
        }()
        
        visitCount = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(14)
            return label
        }()
        
        heartImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            let image = UIImage(systemName: "suit.heart.fill")
            imageView.image = image
            imageView.tintColor = .red
            return imageView
        }()
        
        likeCount = {
            let label = UILabel()
            label.text = ""
            label.textColor = .black
            label.font = label.font.withSize(15)
            return label
        }()
        
        imageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            imageView.backgroundColor = .lightGray
            return imageView
        }()

        contentView.addSubview(content)
        contentView.addSubview(writer)
        contentView.addSubview(date)
        contentView.addSubview(visitCount)
        contentView.addSubview(heartImageView)
        contentView.addSubview(likeCount)
        contentView.addSubview(imageView)
        
        content.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
            $0.width.equalTo(280)
        }
        writer.snp.makeConstraints{
            $0.top.equalTo(content.snp.bottom).offset(5)
            $0.leading.equalTo(content)
        }
        date.snp.makeConstraints{
            $0.top.equalTo(writer)
            $0.leading.equalTo(writer.snp.trailing).offset(10)
        }
        visitCount.snp.makeConstraints{
            $0.top.equalTo(writer)
            $0.leading.equalTo(date.snp.trailing).offset(10)
        }
        heartImageView.snp.makeConstraints{
            $0.top.equalTo(writer.snp.bottom).offset(5)
            $0.leading.equalTo(content)
        }
        likeCount.snp.makeConstraints{
            $0.top.equalTo(heartImageView)
            $0.leading.equalTo(heartImageView.snp.trailing).offset(10)
        }
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.width.equalTo(70)
        }
        
    }
}
