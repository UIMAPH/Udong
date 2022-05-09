//
//  MainStoreListTableViewCell.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/21.
//

import Foundation
import UIKit
import SnapKit

class MainStoreListTableViewCell: UITableViewCell {
    
    var storInfo: Store?
    var storeInfoDetal: DataClass?
    
    lazy var storeName: UILabel = {
        let storeName = UILabel()
        storeName.text = storInfo?.storeName ?? "가메이"
        storeName.font = UIFont(name: "", size: 18)
        
        return storeName
    }()
    lazy var storeCategory: UILabel = {
        let storeCategory = UILabel()
        storeCategory.text = "일식"
        storeCategory.font = UIFont(name: "", size: 11)
        
        return storeCategory
    }()
    lazy var storeCurrentServe: UILabel = {
        let storeCurrentServe = UILabel()
        storeCurrentServe.text = "영업중"
        storeCurrentServe.font = UIFont(name: "", size: 11)
        
        return storeCurrentServe
    }()
    lazy var storeStatus: UILabel = {
        let storeStatus = UILabel()
        storeStatus.text = "방문수 " + "\(storeInfoDetal?.visitCount ?? 100)" + "  리뷰수 " + "\(storeInfoDetal?.reviewCount ?? 100)" + "  단골수 " + "\(storeInfoDetal?.regularCustomerCount ?? 100)"
        storeStatus.textColor = .blue

        return storeStatus
    }()
    
    var cellNum: UILabel = {
        let cellNum = UILabel()
        cellNum.text = "A"
        
        return cellNum;
    }()
    
    lazy var storeImageCollectionView: UICollectionView = {
        let storeImageCollectionViewFlowLayout = UICollectionViewFlowLayout()
        storeImageCollectionViewFlowLayout.scrollDirection = .horizontal
        let storeImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: storeImageCollectionViewFlowLayout)
        storeImageCollectionView.showsHorizontalScrollIndicator = false
        
        return storeImageCollectionView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingLabel();
        settingCollectionView();
    }
    
    private func settingLabel(){
        self.addSubview(cellNum)
        cellNum.snp.makeConstraints{
            $0.leading.top.equalToSuperview().inset(15)
            $0.width.height.equalTo(15)
        }
        
        self.addSubview(storeName)
        storeName.snp.makeConstraints{
            $0.leading.equalTo(cellNum.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(15)
            //$0.trailing.equalTo(storeCategory.snp.leading).offset(-8)
            $0.width.equalTo(200)
            $0.bottom.equalTo(cellNum.snp.bottom)
        }
        
        self.addSubview(storeCurrentServe)
        storeCurrentServe.snp.makeConstraints{
            $0.leading.equalTo(cellNum.snp.leading)
            $0.top.equalTo(cellNum.snp.bottom).offset(11)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        self.addSubview(storeStatus)
        storeStatus.snp.makeConstraints{
            $0.leading.equalTo(storeCurrentServe.snp.trailing).offset(8)
            $0.top.equalTo(cellNum.snp.bottom).offset(11)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(storeCurrentServe.snp.bottom)
        }
    }
    
    private func settingCollectionView(){
        self.addSubview(storeImageCollectionView)
        storeImageCollectionView.register(StoreListTableViewCellCollectionViewCell.self , forCellWithReuseIdentifier: "StoreListTableViewCellCollectionViewCell")
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        storeImageCollectionView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(storeStatus.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    
}

extension MainStoreListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreListTableViewCellCollectionViewCell", for: indexPath) as? StoreListTableViewCellCollectionViewCell else { return UICollectionViewCell()}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 94)
    }

}
