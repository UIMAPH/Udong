//
//  MemeberSecessionViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import UIKit

class MemeberSecessionViewController: UIViewController {

    var agreeContent = false {
        didSet{
            changeView()
        }
    }
    
    @IBOutlet var divider: UIView!
    @IBOutlet var memberArea: UIView!
    @IBOutlet var memberImageVIew: UIImageView!
    @IBOutlet var memberNameLabel: UILabel!
    @IBOutlet var contentArea: UIView!
    @IBOutlet var agreeView: UIView!
    @IBOutlet var agreeimageView: UIImageView!
    @IBOutlet var secessionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
        title = "회원 탈퇴"
    }
    
    private func displaySetting(){
        divider.backgroundColor = .mainblue
        memberArea.layer.masksToBounds = true
        memberArea.layer.cornerRadius = 15
        contentArea.layer.masksToBounds = true
        contentArea.layer.cornerRadius = 15
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAgreeView(_:)))
        agreeView.addGestureRecognizer(g)
        secessionView.backgroundColor = .backgray
    }

    @objc private func tapAgreeView(_ sender: Any){
        agreeContent = !agreeContent
    }
    
    private func changeView(){
        if agreeContent {
            agreeimageView.tintColor = .mainblue
            secessionView.backgroundColor = .mainblue
            secessionView.isUserInteractionEnabled = false
        } else {
            agreeimageView.tintColor = .backgray
            secessionView.backgroundColor = .backgray
            secessionView.isUserInteractionEnabled = true
        }
    }
}
