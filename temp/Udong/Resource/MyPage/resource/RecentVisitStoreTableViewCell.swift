//
//  RecentVisitStoreTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/31.
//

import UIKit

class RecentVisitStoreTableViewCell: UITableViewCell {

    @IBOutlet var storeImageView: UIImageView!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var storeVisiter: UILabel!
    @IBOutlet var storeLover: UILabel!
    @IBOutlet var storeReviewCount: UILabel!
    @IBOutlet var storeBookmarkBtn: UIButton!
    
    @IBAction func tapBookmarkBtn(_ sender: UIButton) {
        if(sender.tintColor == .red){
            sender.tintColor = .systemGray
        } else {
            sender.tintColor = .red
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        storeImageView.layer.masksToBounds = true
        storeImageView.layer.cornerRadius = 30
    }
    
    
}
