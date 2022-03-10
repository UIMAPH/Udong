//
//  PhotoCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/09.
//

import Foundation
import UIKit

class StoreImageListCollectionViewCell: UICollectionViewCell{
    
    var myStoreDetailViewController: StoreDetailViewController!

    let storeImages = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]  // 가게 이미지 저장 - 최대 10개
    
    lazy var storeImageCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.storeImageCollectionViewSetting()
    }
}

extension StoreImageListCollectionViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    private func storeImageCollectionViewSetting(){
        
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        storeImageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        
        contentView.addSubview(storeImageCollectionView)
        storeImageCollectionView.snp.makeConstraints{
            $0.top.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(15)
            $0.width.equalTo(contentView)
            $0.height.equalTo(100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(storeImages.count > 10) {return 10}
        else {return storeImages.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        let storeImageView: UIImageView = {
            let storeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            let storeImage = UIImage(named: storeImages[indexPath.row])  // 가게 이미지 저장
            guard var storeImage = storeImage else{
                print("store image is nil")
                return UIImageView()
            }
            storeImage = StoreDetailViewController().resizeImage(image: storeImage, targetSize: CGSize(width: 100, height: 100))!
            storeImageView.image = storeImage

            return storeImageView
        }()

        cell.addSubview(storeImageView)
        storeImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        self.myStoreDetailViewController.navigationController?.pushViewController(StoreImageDetailViewController(), animated: true)
    }
    
}
