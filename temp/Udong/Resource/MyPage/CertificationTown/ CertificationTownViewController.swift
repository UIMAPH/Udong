//
//   CertificationTownViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/12.
//

import Foundation
import UIKit
import SnapKit

class  CertificationTownViewController: UIViewController{
    
    var currentTown: String?
    lazy var myTownLabel: UILabel = {
        let myTownLabel = UILabel()
        myTownLabel.text = "현재 동네는 \'" + (currentTown ?? "병준이 마음 속") + "\' 입니다."
        myTownLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        return myTownLabel
    }()
    
    var certificationButton: UIButton = {
        let certificationButton = UIButton()
        certificationButton.setTitle("동네 인증 완료하기", for: .normal)
        certificationButton.setTitleColor(.black, for: .normal)
        certificationButton.backgroundColor = .mainblue
        certificationButton.layer.masksToBounds = true
        certificationButton.layer.cornerRadius = 15
        
        return certificationButton
    }()
    
    var mapView = MTMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "동네 인증하기"
        displaySetting()
    }
    
    private func displaySetting(){
        view.addSubview(mapView)
        view.addSubview(myTownLabel)
        view.addSubview(certificationButton)
        mapView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.bounds.height * 0.7)
        }
        myTownLabel.snp.makeConstraints{
            $0.top.equalTo(mapView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        certificationButton.snp.makeConstraints{
            $0.top.equalTo(myTownLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
}
