//
//  MyReivewsTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import UIKit

class MyReivewsTableViewCell: UITableViewCell {

    
    @IBOutlet var storeImageView: UIImageView!
    
    @IBOutlet var storeNameLabel: UILabel!
    
    @IBOutlet var reviewContentsTextField: UITextView!
    
    @IBAction func tapMoreButton(_ sender: UIButton) {
        print("temp button fuction call")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displaySetting()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func displaySetting(){
        storeImageView.layer.masksToBounds = true
        storeImageView.layer.cornerRadius = 15
    }
    
}
