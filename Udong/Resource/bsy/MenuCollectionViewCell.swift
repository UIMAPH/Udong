//
//  menuCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/19.
//

import Foundation

class MenuCollectionViewCell: UICollectionViewCell{
    
    var menu = UILabel()
    var price = UILabel()
    
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

extension MenuCollectionViewCell{
    
    private func displaySetting(){
        
        menu = {
            let label = UILabel()
            label.text = ""
            label.font = label.font.withSize(15)
            return label
        }()
        
        price = {
            let label = UILabel()
            label.text = ""
            label.textColor = .systemBlue
            label.font = label.font.withSize(15)
            return label
        }()

        contentView.addSubview(menu)
        contentView.addSubview(price)
        
        menu.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        price.snp.makeConstraints{
            $0.top.equalTo(menu)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
    }
}
