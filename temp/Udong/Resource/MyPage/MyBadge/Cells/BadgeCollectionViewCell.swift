//
//  BadgeCollectionViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/12.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var badgeImageView: UIImageView!
    @IBOutlet var badgeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        badgeImageView.image = UIImage(named: "sample")
        badgeImageView.layer.masksToBounds = true
        badgeImageView.layer.cornerRadius = 15
    }

}
