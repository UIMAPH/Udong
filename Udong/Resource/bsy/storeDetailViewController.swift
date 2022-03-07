//
//  StoreDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/05.
//

import SwiftUI
import SnapKit

class StoreDetailViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        self.navigationBarSetting()
        self.displaySetting()
    }
}

// MARK: navigation setting

extension StoreDetailViewController{
    private func navigationBarSetting(){
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtnDidTap(_:)))
        backButtonItem.tintColor = .black
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        let storeName = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        storeName.text = "store name"
        
        let storeCategory = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        storeCategory.text = "store category"
        
        containerView.addSubview(storeName)
        containerView.addSubview(storeCategory)
        
        let reviewWrite = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        reviewWrite.text = "review write"
        let reviewWriteButtonItem = UIBarButtonItem(customView: reviewWrite)
        
        navigationItem.leftBarButtonItem = backButtonItem
        //navigationItem.titleView = containerView
        navigationItem.rightBarButtonItem = reviewWriteButtonItem
    }
    
    @objc private func backBtnDidTap(_ sender: Any){
        print("tap back button")
        self.navigationController?.pushViewController(StoreDetailViewController(), animated: true)
    }
}

// MARK: display setting

extension StoreDetailViewController{
    private func displaySetting(){
        let numList = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numList.backgroundColor = .white
        numList.tintColor = .white
        
        let visitNum = "0"  // 백에서 방문수 받아와 저장 (String으로)
        let visitNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        visitNumLabel.text = "방문수 " + visitNum
        
        let reviewNum = "0"  // 백에서 리뷰수 받아와 저장 (String으로)
        let reviewNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        reviewNumLabel.text = "리뷰수 " + reviewNum
        
        let regularNum = "0"  // 백에서 단골수 받아와 저장 (String으로)
        let regularNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        regularNumLabel.text = "단골수 " + regularNum
        
        numList.addSubview(visitNumLabel)
        numList.addSubview(reviewNumLabel)
        numList.addSubview(regularNumLabel)
        
        reviewNumLabel.snp.makeConstraints{
            $0.centerX.equalTo(numList.snp.centerX)
        }
        visitNumLabel.snp.makeConstraints{
            $0.trailing.equalTo(reviewNumLabel.snp.leading).offset(-10)
        }
        regularNumLabel.snp.makeConstraints{
            $0.leading.equalTo(reviewNumLabel.snp.trailing).offset(10)
        }
        
        self.view.addSubview(numList)
        numList.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: UIColor Extension - register RGB init

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")

           self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
       }
    
    convenience init(rgb: Int, a: CGFloat = 1.0){
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF),
            alpha: a
        )
    }
}
