//
//  Review.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/21.
//

import Foundation

class ReviewCollectionViewCell: UICollectionViewCell{
    
    var content = UILabel()
    var writer = UILabel()
    var date = UILabel()
    var visitNum = UILabel()
    
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

extension ReviewCollectionViewCell{
    
    private func displaySetting(){
        
        content = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(15)
            return label
        }()
        
        writer = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(13)
            return label
        }()
        
        date = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(13)
            return label
        }()
        
        visitNum = {
            let label = UILabel()
            label.text = ""
            label.textColor = .gray
            label.font = label.font.withSize(13)
            return label
        }()

        contentView.addSubview(content)
        contentView.addSubview(writer)
        contentView.addSubview(date)
        contentView.addSubview(visitNum)
        
        content.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        writer.snp.makeConstraints{
            $0.top.equalTo(content.snp.bottom).offset(4)
            $0.leading.equalTo(content)
        }
        date.snp.makeConstraints{
            $0.top.equalTo(writer)
            $0.leading.equalTo(writer.snp.trailing).offset(10)
        }
        visitNum.snp.makeConstraints{
            $0.top.equalTo(writer)
            $0.leading.equalTo(date.snp.trailing).offset(10)
        }
        
        
    }
}
