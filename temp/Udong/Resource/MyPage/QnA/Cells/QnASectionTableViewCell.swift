//
//  QnASectionTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import UIKit

class QnASectionTableViewCell: UITableViewCell {

    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3.0, left: 0, bottom: 3, right: 0))
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
