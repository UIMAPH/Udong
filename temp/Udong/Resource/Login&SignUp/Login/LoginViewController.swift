//
//  LoginViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/16.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet var kakaoLoginView: UIImageView!
    @IBOutlet var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        diplaySetting()
        
    }
    
    private func diplaySetting(){
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 15
        logoImageView.backgroundColor = .mainblue
        let tapKakaoViewGesture = UITapGestureRecognizer(target: self, action: #selector(tapKakaoView(_:)))
        kakaoLoginView.addGestureRecognizer(tapKakaoViewGesture)
        kakaoLoginView.isUserInteractionEnabled = true
    }
    
    private func goMain(){
        let nextVC = MainViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func tapKakaoView(_ sender: Any){
        let nextVC = LoginWebViewController()
        self.present(nextVC, animated: true){
            self.goMain()
        }
    }
}

