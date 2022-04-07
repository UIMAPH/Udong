//
//  top5CollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/08.
//

import Foundation

class Top5CollectionViewCell: UICollectionViewCell{
    
    var ranking = UILabel()
    var iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var name = UILabel()
    var title = UILabel()  // 칭호
    var tier = UILabel()
    var numList = UILabel()
    
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
        
    private func displaySetting(){
        contentView.backgroundColor = .white
        
        iconImageView.image = UIImage()
        contentView.addSubview(iconImageView)
        
        let variables = [ranking, name, title, tier, numList]
        for i in 0..<5 {
            variables[i].text = ""
            variables[i].font = UIFont.boldSystemFont(ofSize: 14)
            
            contentView.addSubview(variables[i])
        }
        
        ranking.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        iconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(ranking.snp.trailing).offset(10)
        }
        name.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-20)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(15)
        }
        title.snp.makeConstraints{
            $0.centerY.equalTo(name)
            $0.leading.equalTo(name.snp.trailing).offset(30)
        }
        tier.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(name)
        }
        numList.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(20)
            $0.leading.equalTo(name)
        }
    }
}
