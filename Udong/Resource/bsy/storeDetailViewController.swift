//
//  StoreDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/05.
//

import SwiftUI
import UIKit
import SnapKit

class StoreDetailViewController: UIViewController{
    
    var numList = UIView()
    var tierView = UIView()
    var heartView = UIView()
    
    lazy var collectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    let collectionViewCellStringList = ["StoreImageCell", "RecommendItemCell", "Top5Cell", "StoreInfoCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationBarSetting()
        self.displaySetting()
        self.collectionViewSetting()
    }
}

// MARK: navigation setting

extension StoreDetailViewController{
    private func navigationBarSetting(){
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtnDidTap(_:)))
        backButtonItem.tintColor = .black
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let storeName: UILabel = {
            let storeName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            storeName.text = "name"
            storeName.font = UIFont.boldSystemFont(ofSize: 23)
            return storeName
        }()
        
        let storeCategory: UILabel = {
            let storeCategory = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            storeCategory.text = "category"
            return storeCategory
        }()
        
        containerView.addSubview(storeName)
        containerView.addSubview(storeCategory)
        storeName.snp.makeConstraints{
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView.safeAreaLayoutGuide).offset(-15)
        }
        storeCategory.snp.makeConstraints{
            $0.leading.equalTo(storeName.snp.trailing).offset(5)
            $0.top.equalTo(containerView.safeAreaLayoutGuide).offset(-10)
        }
        
        
        let reviewWrite: UIButton = {
            let reviewWrite = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            reviewWrite.setTitle("review", for: .normal)
            reviewWrite.setTitleColor(.black, for: .normal)
            reviewWrite.addTarget(self, action: #selector(reviewWriteBtnDidTap(_:)), for: .touchUpInside)
            return reviewWrite
        }()
        
        let reviewWriteButtonItem = UIBarButtonItem(customView: reviewWrite)
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.titleView = containerView
        navigationItem.rightBarButtonItem = reviewWriteButtonItem
    }
    
    @objc private func backBtnDidTap(_ sender: Any){
        print("tap back button tabp")
        self.navigationController?.pushViewController(StoreDetailViewController(), animated: true)
    }
    
    @objc private func reviewWriteBtnDidTap(_ sender: Any){
        print("review write button tap")
        self.navigationController?.pushViewController(StoreImageDetailViewController(), animated: true)  // 리뷰 작성 페이지로 수정
    }
    
}

// MARK: display setting

extension StoreDetailViewController{
    
    private func displaySetting(){
        
        // MARK: 방문수, 리뷰수, 단골수
        
        numList = {
            let numList = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400))
            numList.backgroundColor = .white
            return numList
        }()
        
        let visitNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        visitNumLabel.text = "방문수 "
        
        let reviewNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        reviewNumLabel.text = "리뷰수 "
        
        let regularNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        regularNumLabel.text = "단골수 "
        
        let numArr = ["0", "0", "0"] // 백에서 방문수, 리뷰수, 단골수 받아와 저장 (String으로)
        let labelArr = [visitNumLabel, reviewNumLabel, regularNumLabel]
        
        for i in 0..<3{
            labelArr[i].font = labelArr[i].font.withSize(16)
            labelArr[i].textColor = .systemBlue
            labelArr[i].text! += numArr[i]
            
            numList.addSubview(labelArr[i])
        }
        
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
            $0.height.equalTo(20)
        }
        
        
        // MARK: 사용자의 단골 등급
        
        tierView = {
            let tierView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            tierView.backgroundColor = .white
            return tierView
        }()
        
        let tierImage: UIImage = {
            let tierImage = UIImage(named: "new-moon.png") // 티어 이미지 설정
            guard var tierImage = tierImage else{
                print("tier image is nil")
                return UIImage()
            }
            tierImage = self.resizeImage(image: tierImage, targetSize: CGSize(width: 30, height: 30))!
            
            return tierImage
        }()
        
        let tierImageView: UIImageView = {
            let tierImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            tierImageView.image = tierImage
            
            return tierImageView
        }()
        
        let tierName: UILabel = {
            let tierName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            tierName.text = "tier name"  // 티어 String)
            tierName.font = UIFont.boldSystemFont(ofSize: 14)
            return tierName
        }()
        
        let myvisitNum = "0"  // 유저의 방문수 받아와 저장 (String)
        let myVisitNumLabel: UILabel = {
            let myVisitNumLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            myVisitNumLabel.text = "나는 이 가게를 " + myvisitNum + "번째 방문했어요"
            myVisitNumLabel.font = UIFont.boldSystemFont(ofSize: 12)
            return myVisitNumLabel
        }()
        
        tierView.addSubview(tierImageView)
        tierView.addSubview(tierName)
        tierView.addSubview(myVisitNumLabel)
        
        tierImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(tierView.snp.centerY)
        }
        tierName.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(tierImageView.snp.trailing).offset(10)
        }
        myVisitNumLabel.snp.makeConstraints{
            $0.leading.equalTo(tierName)
            $0.top.equalTo(tierName.snp.bottom)
        }
        
        self.view.addSubview(tierView)
        tierView.snp.makeConstraints{
            $0.top.equalTo(numList.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 7.5 / 10)
            $0.height.equalTo(50)
        }
        
        
        // MARK: 찜하기
        
        heartView = {
            let heartView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            heartView.backgroundColor = .white
            return heartView
        }()
        
        let heartButton: UIButton = {
            let heartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            let heartImage = UIImage(systemName: "suit.heart.fill")
            //heartImage = self.resizeImage(image: heartImage!, targetSize: CGSize(width: 30, height: 30))!
            heartButton.setImage(heartImage, for: .normal)
            heartButton.addTarget(self, action: #selector(heartButtonDidTap(_:)), for: .touchUpInside)
            heartButton.tintColor = .lightGray
            return heartButton
        }()
        
        let heartLabel: UILabel = {
            let heartLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            heartLabel.text = "찜하기"
            heartLabel.font = UIFont.boldSystemFont(ofSize: 16)
            return heartLabel
        }()
        
        heartView.addSubview(heartButton)
        heartView.addSubview(heartLabel)
        
        heartButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        heartLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(heartButton.snp.trailing).offset(5)
        }
        
        self.view.addSubview(heartView)
        heartView.snp.makeConstraints{
            $0.top.equalTo(numList.snp.bottom).offset(10)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 2.5 / 10)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func heartButtonDidTap(_ sender: UIButton){
        print("heart button tap")
        if(sender.tintColor == .lightGray) { sender.tintColor = .red }
        else { sender.tintColor = .lightGray }
    }
}


// MARK: collectionView setting

extension StoreDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    public func collectionViewSetting(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: collectionViewCellStringList[0])
        collectionView.register(RecommendItemCell.self, forCellWithReuseIdentifier: collectionViewCellStringList[1])
        collectionView.register(Top5Cell.self, forCellWithReuseIdentifier: collectionViewCellStringList[2])
        collectionView.register(StoreInfoCell.self, forCellWithReuseIdentifier: collectionViewCellStringList[3])
        
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        collectionView.snp.makeConstraints{
            $0.top.equalTo(tierView.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellStringList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellStringList[indexPath.row], for: indexPath) as! StoreImageCell
            cell.myStoreDetailViewController = self
            cell.backgroundColor = .white
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellStringList[indexPath.row], for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.row == 0){
            return CGSize(width: UIScreen.main.bounds.width, height: 110)
        }
        else if(indexPath.row == 1){
            return CGSize(width: UIScreen.main.bounds.width, height: 125)
        }
        else if(indexPath.row == 2){
            return CGSize(width: UIScreen.main.bounds.width, height: 105)
        }
        else{
            return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 1){
            self.navigationController?.pushViewController(RecommendItemDetailViewController(), animated: true)
        }
    }
}

// MARK: image resize function

extension StoreDetailViewController{
    public func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
