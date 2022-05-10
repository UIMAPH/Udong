//
//  MyCustomStoreTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import UIKit

class MyCustomStoreTableViewCell: UITableViewCell {

    
    @IBOutlet var storeImageView: UIImageView!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var storeVisiter: UILabel!
    @IBOutlet var storeLover: UILabel!
    @IBOutlet var storeReviewCount: UILabel!
    @IBOutlet var storeTierAboutMe: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storeImageView.layer.masksToBounds = true
        storeImageView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
