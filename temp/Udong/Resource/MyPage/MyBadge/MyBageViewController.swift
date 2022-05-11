//
//  MyBageViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import Foundation
import UIKit

class MyBadgeViewController: UIViewController {
    
    var usingBadgeCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        fl.itemSize = CGSize(width: 140, height: 140)
        let usingCV = UICollectionView(frame: .zero, collectionViewLayout: fl)
        usingCV.backgroundColor = .red
        
        return usingCV
    }()
    
    var allBadgeCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        fl.itemSize = CGSize(width: 140, height: 140)
        let allBadgeCV = UICollectionView(frame: .zero, collectionViewLayout: fl)
        allBadgeCV.backgroundColor = .blue
        allBadgeCV.isPagingEnabled = true
      
        
        return allBadgeCV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "내 뱃지"
        badgeSetting()
    }
    
    private func badgeSetting(){
        view.addSubview(usingBadgeCollectionView)
        view.addSubview(allBadgeCollectionView)
        usingBadgeCollectionView.delegate = self
        usingBadgeCollectionView.dataSource = self
        allBadgeCollectionView.delegate = self
        allBadgeCollectionView.dataSource = self
        usingBadgeCollectionView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        allBadgeCollectionView.snp.makeConstraints{
            $0.top.equalTo(usingBadgeCollectionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        usingBadgeCollectionView.register(MyBadgeCollectionViewCell.self, forCellWithReuseIdentifier: "MyBadgeCollectionViewCell")
        allBadgeCollectionView.register(MyBadgeCollectionViewCell.self, forCellWithReuseIdentifier: "MyBadgeCollectionViewCell")
    }
}

extension MyBadgeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBadgeCollectionViewCell", for: indexPath) as? MyBadgeCollectionViewCell else { return UICollectionViewCell() }
        if(indexPath.section % 2 == 0){
            cell.backgroundColor = .red
        }else {
            cell.backgroundColor = .black
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if(collectionView == allBadgeCollectionView){
//            return UIEdgeInsets(top: 30, left: (view.frame.width - 195)/2, bottom: 15, right: (view.frame.width - 195)/2 )
//        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
}
