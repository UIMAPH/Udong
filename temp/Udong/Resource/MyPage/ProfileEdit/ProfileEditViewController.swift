//
//  ProfileEditViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/09.
//

import Foundation
import UIKit
import SnapKit

class ProfileEditViewController: UIViewController {
    
    var proflieImageView : UIImageView = {
        let profileImage = UIImage(named: "sample")
        let profileImageView = UIImageView(image: profileImage)
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 20
        
        return profileImageView
    }()
//
//    var EditButton : UIView = {
//        let cameraImageview = UIImageView(image: UIImage(named: "camera"))
//        cameraImageview.tintColor = .black
//        let EditButton = UIView()
//        EditButton.addSubview(cameraImageview)
//        cameraImageview.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(30)
//        }
//        EditButton.backgroundColor = .gray
//
//        return EditButton
//    }()
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
    }
    
    private func displaySetting(){
        
    }
}
