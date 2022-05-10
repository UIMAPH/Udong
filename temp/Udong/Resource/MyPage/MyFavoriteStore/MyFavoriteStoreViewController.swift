//
//  MyFavoriteStoreViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import Foundation
import UIKit
import SnapKit

class MyFavoriteStoreViewController: UIViewController {
    
    let customButton: UIButton = {
        let customBtn = UIButton()
        customBtn.backgroundColor = .white
        customBtn.setTitle("내 단골 가게", for: .normal)
        customBtn.setTitleColor(.black, for: .normal)
        
        return customBtn
    }()
    
    let wishButton: UIButton = {
        let wishBtn = UIButton()
        wishBtn.backgroundColor = .mainblue
        wishBtn.setTitle("내가 찜한 가게", for: .normal)
        wishBtn.setTitleColor(.black, for: .normal)
        
        return wishBtn
    }()
    
    lazy var ButtonList: [UIButton] = {return [customButton, wishButton]}()
    
    let pvc = MyFavortieListPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var currentIdx: Int = 0 {
        didSet{
            changBtn()
            print(currentIdx)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내 단골 가게"
        displaySetting()
        addPageViewController()
    }
    
    private func displaySetting(){
        view.addSubview(wishButton)
        view.addSubview(customButton)
        customButton.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.bounds.width * 0.5)
            $0.height.equalTo(40)
        }
        wishButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.bounds.width * 0.5)
            $0.height.equalTo(40)
        }
    }
    
    private func changBtn(){
        for (index, element) in ButtonList.enumerated() {
            if index == currentIdx {
                element.backgroundColor = .white
            }
            else {
                element.backgroundColor = .mainblue
            }
        }
    }
}

extension MyFavoriteStoreViewController: pageChange{
    
    func passIndex(idx: Int) {
        currentIdx = idx;
    }
    
    private func addPageViewController(){
        self.addChild(pvc)
        pvc.appdelegate = self
        pvc.view.translatesAutoresizingMaskIntoConstraints = false
        guard let temp = pvc.view else { return }
        view.addSubview(temp)
        temp.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(wishButton.snp.bottom)
            
        }
        
    }
}
