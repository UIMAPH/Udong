//
//  Top5CollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/12.
//

import Foundation
import SwiftUI

class Top5Cell: UICollectionViewCell{
    
    var titleLabel = UILabel()
    var top5Images: [String] = []  // // top5 단골 이미지 저장
    
    lazy var collectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        top5Images = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 단골 이미지 저장
        
        if(top5Images.count != 0){
            self.displaySetting()
            self.collectionViewSetting()
        }
        else{
            self.noRegularDisplaySetting()
        }
    }
    
}

extension Top5Cell{
    
    // MARK: display setting
    
    private func displaySetting(){
        titleLabel = {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = "이 가게 TOP5 단골"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return titleLabel
        }()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    
    // MARK: display setting when there is no regular
    
    private func noRegularDisplaySetting(){
        let label1: UILabel = {
            let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label1.text = "아직 단골손님이 없어요!"
            label1.font = UIFont.boldSystemFont(ofSize: 20)
            return label1
        }()
        
        let label2: UILabel = {
            let label2 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label2.text = "우리 동네 가게라면 방문하고 리뷰를 작성해보세요!"
            label2.font = UIFont.boldSystemFont(ofSize: 16)
            return label2
        }()
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        
        label1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        label2.snp.makeConstraints{
            $0.top.equalTo(label1.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
}

extension Top5Cell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: collectionView setting
    
    private func collectionViewSetting(){
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(contentView)
            $0.height.equalTo(50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top5Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        
        let top5ImageView: UIImageView = {
            let top5ImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            let top5Image = UIImage(named: top5Images[indexPath.row]) // 추천키워드 이미지 설정
            guard var top5Image = top5Image else{
                print("top5Image is nil")
                return UIImageView()
            }
            top5Image = StoreDetailViewController().resizeImage(image: top5Image, targetSize: CGSize(width: 40, height: 40))!
            top5ImageView.image = top5Image
            
            return top5ImageView
        }()
        
        cell.addSubview(top5ImageView)
        top5ImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
