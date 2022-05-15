//
//  FirstViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/15.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var LoginButton: UIButton!
    @IBOutlet var SignUpButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUpButton.layer.masksToBounds = true
        SignUpButton.layer.cornerRadius = 15
        SignUpButton.backgroundColor = .mainblue
    }
    
}
