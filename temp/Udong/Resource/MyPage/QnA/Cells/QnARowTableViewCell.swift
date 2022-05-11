//
//  QnARowTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import UIKit

class QnARowTableViewCell: UITableViewCell {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .mainblue
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
