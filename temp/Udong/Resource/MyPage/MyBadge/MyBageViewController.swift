//
//  MyBageViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import Foundation
import UIKit

class MyBadgeViewController: UIViewController {
    
    var allList: [BadgeModel]?
    var usingList: [BadgeModel]?
    
    var usingBadgeCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        fl.itemSize = CGSize(width: 150, height: 150)
        let usingBadge = UICollectionView(frame: .zero, collectionViewLayout: fl)
        usingBadge.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        usingBadge.showsHorizontalScrollIndicator = false
        
        return usingBadge
    }()
    
    var allBadgeCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .vertical
        fl.itemSize = CGSize(width: 150, height: 150)
        let allBadge = UICollectionView(frame: .zero, collectionViewLayout: fl)
        allBadge.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        allBadge.showsVerticalScrollIndicator = false
        
        return allBadge
    }()
    
    var divider: UIView = {
        let divier = UIView()
        divier.backgroundColor = .mainblue
        
        return divier
    }()
    
    var moreButton: UIButton = {
        let moreBtn = UIButton()
        moreBtn.setImage(UIImage(named: "moreBtn"), for: .normal)
        
        return moreBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=============================================")
        title = "내 뱃지"
        displaySetting()
        settingCollectionView()
        loadBadge()
    }
    
    private func displaySetting(){
        view.addSubview(usingBadgeCollectionView)
        view.addSubview(allBadgeCollectionView)
        view.addSubview(divider)
        view.addSubview(moreButton)
        usingBadgeCollectionView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(180)
        }
        divider.snp.makeConstraints{
            $0.top.equalTo(usingBadgeCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(3)
        }
        moreButton.snp.makeConstraints{
            $0.top.equalTo(divider.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(24)
        }
        allBadgeCollectionView.snp.makeConstraints{
            $0.top.equalTo(divider.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview()
        }
    }
    private func loadBadge(){
        BadgeService.shared.loadBadge { [weak self] result in
            switch result {
            case .success(let networkReulst):
                if let temp = networkReulst as? NetkResponseWithArray<BadgeModel>,
                   let badgeList = temp.data {
                    badgeList.forEach{
                        print($0)
                    }
                    self?.allList = badgeList
                    self?.usingList?.removeAll()
                    badgeList.forEach{
                        if $0.active ?? false {
                            self?.usingList?.append($0)
                        }
                    }
                    DispatchQueue.main.async {
                        self?.usingBadgeCollectionView.reloadData()
                        self?.allBadgeCollectionView.reloadData()
                    }
                }
            case .requestErr(_):
                fatalError("fuck you")
            case .pathErr:
                fatalError("fuck you")
            case .serverErr:
                fatalError("fuck you")
            case .networkFail:
                fatalError("fuck you")
            }
            
         }
    }
    
    private func settingCollectionView(){
        usingBadgeCollectionView.register(UINib(nibName: "BadgeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BadgeCollectionViewCell")
        allBadgeCollectionView.register(UINib(nibName: "BadgeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BadgeCollectionViewCell")
        usingBadgeCollectionView.delegate = self
        usingBadgeCollectionView.dataSource = self
        allBadgeCollectionView.delegate = self
        allBadgeCollectionView.dataSource = self
    }
}

extension MyBadgeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == allBadgeCollectionView {
            return allList?.count ?? 0
        } else {
            return usingList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionViewCell", for: indexPath) as? BadgeCollectionViewCell else {return UICollectionViewCell()}
        if collectionView == allBadgeCollectionView {
            cell.badgeNameLabel.text = allList?[indexPath.row].badgeName
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == allBadgeCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BadgeCollectionViewCell else { return }
            cell.badgeImageView.layer.borderColor = UIColor.mainblue.cgColor
            cell.badgeImageView.layer.borderWidth = 3
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == allBadgeCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? BadgeCollectionViewCell else { return }
            cell.badgeImageView.layer.borderWidth = 0
        }
    }
}
