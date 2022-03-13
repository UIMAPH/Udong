//
//  KeywordRecommendCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/12.
//

import Foundation
import UIKit

class RecommendItemCell: UICollectionViewCell{
    
    var recommendItemView = UIView()
    let recommendItem = "단무지 맛집"  // 추천항목 저장
    var recommendItemImages: [String] = []  // 추천항목 이미지 저장
    
    lazy var recommendItemCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        recommendItemImages = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 추천키워드 이미지 저장
        
        if(recommendItemImages.count != 0){
            self.displaySetting()
            self.collectionViewSetting()
        }
        else{
            self.noRecommendDisplaySetting()
        }
    }
}

extension RecommendItemCell{
    
    // MARK: display setting
    
    private func displaySetting(){
        recommendItemView = {
            let recommendItemView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            recommendItemView.backgroundColor = .white
            return recommendItemView
        }()
        
        let recommendItemImageView: UIImageView = {
            let recommendItemImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            let recommendItemImage = UIImage(named: recommendItemImages[0]) // 추천 키워드 이미지 설정
            guard var recommendItemImage = recommendItemImage else{
                print("recommendItem image is nil")
                return UIImageView()
            }
            /// 이미지 사이즈: 50 X 50
            recommendItemImage = StoreDetailViewController().resizeImage(image: recommendItemImage, targetSize: CGSize(width: 50, height: 50))!
            
            recommendItemImageView.image = recommendItemImage
            return recommendItemImageView
        }()
        
        let recommendLabel1: UILabel = {
            let recommendLabel1 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            recommendLabel1.text = "로컬들이 선택한"
            recommendLabel1.font = UIFont.boldSystemFont(ofSize: 14)
            return recommendLabel1
        }()
        
        let recommendLabel2: UILabel = {
            let recommendLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            recommendLabel2.text = "\"" + recommendItem + "\""
            recommendLabel2.font = UIFont.boldSystemFont(ofSize: 14)
            return recommendLabel2
        }()
        
        recommendItemView.addSubview(recommendItemImageView)
        recommendItemView.addSubview(recommendLabel1)
        recommendItemView.addSubview(recommendLabel2)
    
        recommendItemImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        recommendLabel1.snp.makeConstraints{
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(recommendItemImageView.snp.trailing).offset(15)
        }
        recommendLabel2.snp.makeConstraints{
            $0.top.equalTo(recommendLabel1.snp.bottom)
            $0.leading.equalTo(recommendItemImageView.snp.trailing).offset(15)
        }
        
        contentView.addSubview(recommendItemView)
        recommendItemView.snp.makeConstraints{
            $0.top.leading.equalTo(contentView)
        }
    }
    
    
    // MARK: display setting when there is no recommend keyword
    
    private func noRecommendDisplaySetting(){
        let label1: UILabel = {
            let label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label1.text = "아직 추천항목이 없어요!"
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

extension RecommendItemCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    // MARK: collectionView setting
    
    private func collectionViewSetting(){
        contentView.addSubview(recommendItemCollectionView)
            recommendItemCollectionView.delegate = self
            recommendItemCollectionView.dataSource = self
            recommendItemCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "circleCollectionViewCell")
        
            recommendItemCollectionView.snp.makeConstraints{
            $0.top.equalTo(recommendItemView.snp.bottom).offset(65)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(contentView)
            $0.height.equalTo(50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendItemImages.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCollectionViewCell", for: indexPath)
        
        let recommendItemImageView: UIImageView = {
            let recommendItemImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            
            let recommendItemImage = UIImage(named: recommendItemImages[indexPath.row + 1]) // 추천키워드 이미지 설정
            guard var recommendItemImage = recommendItemImage else{
                print("recommendItem image is nil")
                return UIImageView()
            }
            /// 이미지 사이즈: 40 X 40
            recommendItemImage = StoreDetailViewController().resizeImage(image: recommendItemImage, targetSize: CGSize(width: 40, height: 40))!
            recommendItemImageView.image = recommendItemImage
            
            return recommendItemImageView
        }()
        
        cell.addSubview(recommendItemImageView)
        recommendItemImageView.snp.makeConstraints{
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


