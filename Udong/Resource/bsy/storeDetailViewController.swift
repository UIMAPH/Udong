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
    
    let storeImages = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]  // 가게 이미지 저장 - 최대 10개
    
    let recommendItem = "단무지 맛집"  // 추천항목 저장
    var recommendItemImages: [String] = []  // 추천항목 이미지 저장
    
    var top5Images: [String] = []  // // top5 단골 이미지 저장
    
    let storeInfoIcons = [UIImage(systemName: "mappin.and.ellipse"), UIImage(systemName: "phone.fill"), UIImage(systemName: "clock")]
    var storeInfos = ["주소", "전화번호", "영업시간"]  /// 가게 주소, 전화번호, 영업시간 저장
    let officeHours = ["월요일", "월요일", "월요일", "월요일", "월요일", "월요일", "월요일"]
    
    var numListView = UIView()
    var tierView = UIView()
    var heartView = UIView()
    
    lazy var storeImageCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    var recommendItemView = UIView()
    lazy var recommendItemCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    var top5View = UIView()
    lazy var top5collectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    lazy var storeInfoCollectionView: UICollectionView = {
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
        
        // display setting func call
        self.numListViewSetting()
        self.tierViewSetting()
        self.heartViewSetting()
        
        self.storeImagecollectionViewSetting()
        self.recommendItemViewSetting()
        self.top5ViewSetting()
        self.storeInfoViewSetting()
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
    
    // MARK: 방문수, 리뷰수, 단골수
    
    private func numListViewSetting(){
        numListView = {
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
            
            numListView.addSubview(labelArr[i])
        }
        
        reviewNumLabel.snp.makeConstraints{
            $0.centerX.equalTo(numListView.snp.centerX)
        }
        visitNumLabel.snp.makeConstraints{
            $0.trailing.equalTo(reviewNumLabel.snp.leading).offset(-10)
        }
        regularNumLabel.snp.makeConstraints{
            $0.leading.equalTo(reviewNumLabel.snp.trailing).offset(10)
        }
        
        self.view.addSubview(numListView)
        numListView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(20)
        }
    }
    
    // MARK: 사용자의 단골 등급
    
    private func tierViewSetting(){
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
            $0.top.equalTo(numListView.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 7.5 / 10)
            $0.height.equalTo(50)
        }
        
    }
    
    // MARK: 찜하기
    
    private func heartViewSetting(){
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
            $0.top.equalTo(numListView.snp.bottom).offset(10)
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
    
    // MARK: storeImageCollectionView setting
    
    private func storeImagecollectionViewSetting(){
        
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        
        storeImageCollectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: "storeImageCell")
        
        self.view.addSubview(storeImageCollectionView)
        //collectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        storeImageCollectionView.snp.makeConstraints{
            $0.top.equalTo(tierView.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            //$0.width.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
    }

// MARK: recommendItemView setting
    
    private func recommendItemViewSetting(){
        recommendItemImages = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 추천키워드 이미지 저장

        recommendItemView = {
            let recommendItemView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            recommendItemView.backgroundColor = .white
            return recommendItemView
        }()
        
        self.view.addSubview(recommendItemView)
        recommendItemView.snp.makeConstraints{
            $0.top.equalTo(storeImageCollectionView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(125)
        }
        
        if(recommendItemImages.count != 0){

            let recommendItemImageView: UIImageView = {
                let recommendItemImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                
                let recommendItemImage = UIImage(named: recommendItemImages[0])
                guard var recommendItemImage = recommendItemImage else{
                    print("recommendItem image is nil")
                    return UIImageView()
                }
                recommendItemImage = self.resizeImage(image: recommendItemImage, targetSize: CGSize(width: 50, height: 50))!
                
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
            
            /// recommendItemcollectionView setting
            
            recommendItemView.addSubview(recommendItemCollectionView)
            recommendItemCollectionView.delegate = self
            recommendItemCollectionView.dataSource = self
            recommendItemCollectionView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCollectionViewCell")
            
            recommendItemCollectionView.snp.makeConstraints{
                $0.top.equalTo(recommendItemImageView.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            
            // TODO: recommendItemView 클릭 시 액션 정의 - uiview에 터치 이벤트 추가
            
            
        }
        else{  // setting when there is no recommend item
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
            
            recommendItemView.addSubview(label1)
            recommendItemView.addSubview(label2)
            
            label1.snp.makeConstraints{
                $0.top.equalToSuperview().offset(15)
                $0.leading.equalToSuperview().offset(15)
            }
            label2.snp.makeConstraints{
                $0.top.equalTo(label1.snp.bottom).offset(5)
                $0.leading.equalTo(label1)
            }
        }
    }
    
    private func top5ViewSetting(){
        
        top5Images = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 단골 이미지 저장
        
        top5View = {
            let top5View = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            top5View.backgroundColor = .white
            return top5View
        }()
        
        self.view.addSubview(top5View)
        top5View.snp.makeConstraints{
            $0.top.equalTo(recommendItemView.snp.bottom)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }

        if(top5Images.count != 0){
            
            let titleLabel : UILabel = {
                let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                titleLabel.text = "이 가게 TOP5 단골"
                titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
                return titleLabel
            }()
            
            top5View.addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.top.equalToSuperview().offset(15)
                $0.leading.equalToSuperview().offset(20)
            }
            
            // top5collectionView setting
            
            top5View.addSubview(top5collectionView)
            top5collectionView.delegate = self
            top5collectionView.dataSource = self
            top5collectionView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCollectionViewCell")
            
            top5collectionView.snp.makeConstraints{
                $0.top.equalTo(titleLabel.snp.bottom).offset(5)
                $0.leading.equalTo(titleLabel)
                $0.width.equalToSuperview()
                $0.height.equalTo(50)
            }
            
            // TODO: top5View 클릭 시 액션 정의 - uiview에 터치 이벤트 추가
        }
        else{  // setting when there is no regular
            
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
            
            top5View.addSubview(label1)
            top5View.addSubview(label2)
            
            label1.snp.makeConstraints{
                $0.top.equalToSuperview().offset(15)
                $0.leading.equalToSuperview().offset(15)
            }
            label2.snp.makeConstraints{
                $0.top.equalTo(label1.snp.bottom).offset(5)
                $0.leading.equalTo(label1)
            }
        }
    }
    
    // MARK: storeInfoView setting
    
    private func storeInfoViewSetting(){
        
        var detailBtnState: Bool = false
        
        self.view.addSubview(storeInfoCollectionView)
        storeInfoCollectionView.delegate = self
        storeInfoCollectionView.dataSource = self
        storeInfoCollectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "storeInfoCollectionViewCell")
        
        storeInfoCollectionView.snp.makeConstraints{
            $0.top.equalTo(top5View.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.height.equalTo(200)
        }
        
    }
    
}


// MARK: collectionView setting

extension StoreDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.storeImageCollectionView {
            if(storeImages.count > 10) {return 10}
            else {return storeImages.count}
        }
        if collectionView == self.recommendItemCollectionView {
            return recommendItemImages.count - 1
        }
        if collectionView == self.top5collectionView {
            return top5Images.count
        }
        if collectionView == self.storeInfoCollectionView {
            return 3
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.storeImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeImageCell", for: indexPath) as! StoreImageCell
            
            let storeImage = UIImage(named: storeImages[indexPath.row])
            guard var storeImage = storeImage else{
                print("store image is nil")
                return cell
            }
            storeImage = self.resizeImage(image: storeImage, targetSize: CGSize(width: 100, height: 100))!
            cell.storeImageView.image = storeImage
            cell.backgroundColor = .lightGray
            
            return cell
        }
        
        if collectionView == self.recommendItemCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCollectionViewCell", for: indexPath) as! CircleCollectionViewCell
            
            let recommendItemImage = UIImage(named: recommendItemImages[indexPath.row + 1])
            guard var recommendItemImage = recommendItemImage else{
                print("recommendItem image is nil")
                return cell
            }
            recommendItemImage = self.resizeImage(image: recommendItemImage, targetSize: CGSize(width: 40, height: 40))!
            cell.imageView.image = recommendItemImage
            
            return cell
        }
        
        if collectionView == self.top5collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCollectionViewCell", for: indexPath) as! CircleCollectionViewCell
            
            let top5Image = UIImage(named: top5Images[indexPath.row]) // 추천키워드 이미지 설정
            guard var top5Image = top5Image else{
                print("top5Image is nil")
                return cell
            }
            top5Image = self.resizeImage(image: top5Image, targetSize: CGSize(width: 40, height: 40))!
            cell.imageView.image = top5Image
            
            return cell
        }
        
        if collectionView == self.storeInfoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeInfoCollectionViewCell", for: indexPath) as! StoreInfoCollectionViewCell
            
            if(indexPath.row == 2){
                cell.detailBtnSetting()
            }
            
            cell.iconImageView.image = storeInfoIcons[indexPath.row]
            cell.label.text = storeInfos[indexPath.row]
            
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeImageCell", for: indexPath) as! StoreImageCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.storeImageCollectionView {
            return CGSize(width: 100, height: 100)
        }
        if collectionView == self.recommendItemCollectionView || collectionView == self.top5collectionView {
            return CGSize(width: 40, height: 40)
        }
        if collectionView == self.storeInfoCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 20)
        }
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.storeImageCollectionView {
            return 3
        }
        if collectionView == self.recommendItemCollectionView || collectionView == self.top5collectionView || collectionView == self.storeInfoCollectionView {
            return 15
        }
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.storeImageCollectionView {
            print("\(indexPath.row)")
            self.navigationController?.pushViewController(StoreImageDetailViewController(), animated: true)
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
