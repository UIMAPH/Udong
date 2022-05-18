//
//  SixButtonTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/17.
//

import UIKit

class SixButtonTableViewCell: UITableViewCell {

    
    var appDelegate: tapSixButton?
    
    @IBAction func tapProfileEdit(_ sender: UIButton) {
        let nextVC = ProfileEditViewController()
        appDelegate?.tapButton(vc: nextVC)
        
    }
    @IBAction func tapMyStore(_ sender: UIButton) {
        let nextVC = MyFavoriteStoreViewController()
        appDelegate?.tapButton(vc: nextVC)
    }
    
    @IBAction func tapMyBadge(_ sender: UIButton) {
        let nextVC = MyBadgeViewController()
        appDelegate?.tapButton(vc: nextVC)
    }
    
    @IBAction func tapCertificationTown(_ sender: UIButton) {
        let nextVC = CertificationTownViewController()
        appDelegate?.tapButton(vc: nextVC)
    }
    
    @IBAction func tapMyReview(_ sender: UIButton) {
        let nextVC = MyReviewsViewController()
        appDelegate?.tapButton(vc: nextVC)
    }
    
    @IBAction func tapSetting(_ sender: UIButton) {
        let nextVC = UIViewController()
        appDelegate?.tapButton(vc: nextVC)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol tapSixButton {
    func tapButton(vc: UIViewController)
}
