//
//  MemberSecessionViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import Foundation
import UIKit

class MemberSecessionViewController: UIViewController{
    
    var divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .mainblue
        
        return divider;
    }()
    
    var memberArea: UIView = {
        let memberArea = UIView()
        memberArea.backgroundColor = .backgray
        return memberArea
    }()
    
    var warningArea: UIView = {
        let warningArea = UIView()
        warningArea.backgroundColor = .backgray
        
        return warningArea
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
    }
    
    private func displaySetting(){
        
    }
}
