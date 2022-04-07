//
//  test.swift
//  movieAPI
//
//  Created by  sangyeon on 2022/04/05.
//

import Foundation

//
//  StoreDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/05.
//

import SwiftUI
import UIKit
import SnapKit

let SPACING_FOR_VIEW = 2

class StoreDetailViewController: UIViewController{
    
    let myTierImage: UIImage? = UIImage(named: "new-moon.png")
    let tierName: String = "tier name"
    let myVisitNum: Int = 0
    
    let storeImages: [String] = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]  // 가게 이미지 저장 - 최대 10개
    
    let recommendItem = "단무지 맛집"  // 추천항목 저장
    var recommendItemImages: [String] = []  // 추천항목 이미지 저장
    
    var top5Images: [String] = []  // // top5 단골 이미지 저장
    
    let storeInfoIcons = [UIImage(systemName: "mappin.and.ellipse"), UIImage(systemName: "phone.fill"), UIImage(systemName: "clock")]
    var storeInfos: [String] = ["주소", "전화번호", "영업시간"]  /// 가게 주소, 전화번호, 영업시간 저장
    let officeHours: [String] = ["월요일", "월요일", "월요일", "월요일", "월요일", "월요일", "월요일"]
    
    let menus: [String] = ["김치 치즈 가쯔동", "김치 치즈 가쯔동", "김치 치즈 가쯔동", "김치 치즈 가쯔동"]
    let prices: [String] = ["7,500원", "7,500원", "7,500원", "7,500원"]
    
    let reviews: [String] = ["내용입니다1", "작성자1", "22.03.21", "1", "내용입니다2", "작성자2", "22.03.22", "2"]
    
    var recommendStoreImages: [String] = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 추천 가게 이미지 저장
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var numListView = UIView()
    var tierView = UIView()
    var heartView = UIView()
    
    var storeImageView = UIView()
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
    
    var storeInfoView = UIView()
    lazy var storeInfoCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    var officeHourBtnState: Bool = false
    
//    lazy var officeHourCollectionView: UICollectionView = {
//        let f1 = UICollectionViewFlowLayout()
//        f1.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
//        return cv
//    }()
  
    var menuView = UIView()
    lazy var menuCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    var reviewView = UIView()
    lazy var reviewCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    var locationView = UIView()
    
    var recommendStoreView = UIView()
    lazy var recommendStoreCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationBarSetting()
        self.scrollViewSetting()
        
        // display setting func call
        self.numListViewSetting()
        self.tierViewSetting()
        self.heartViewSetting()
        
        self.storeImagecollectionViewSetting()
        self.recommendItemViewSetting()
        self.top5ViewSetting()
        self.storeInfoViewSetting()
        
        self.menuViewSetting()
        self.reviewViewSetting()
        
        self.locationViewSetting()
        self.recommendStoreViewSetting()
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func reviewWriteBtnDidTap(_ sender: Any){
        print("review write button tap")
        self.navigationController?.pushViewController(StoreImageDetailViewController(), animated: true)  // 리뷰 작성 페이지로 수정 - 동네 주민일 시 8-0, 아니면 8-2 페이지로 이동
    }
}

// MARK: scrollView setting

extension StoreDetailViewController {
    private func scrollViewSetting(){
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: display setting

extension StoreDetailViewController{
    
    // MARK: 방문수, 리뷰수, 단골수
    
    private func numListViewSetting(){
        numListView = {
            let numList = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
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
        
        scrollView.addSubview(numListView)
        numListView.snp.makeConstraints{
            $0.top.equalTo(scrollView)
            $0.width.equalTo(scrollView.safeAreaLayoutGuide)
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
            let image = myTierImage // 티어 이미지 설정
            guard var image = image else{
                print("tier image is nil")
                return UIImage()
            }
            image = self.resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))!
            
            return image
        }()
        
        let tierImageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            imageView.image = tierImage
            return imageView
        }()
        
        let tierNameLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = tierName
            label.font = UIFont.boldSystemFont(ofSize: 14)
            return label
        }()
        
        let myvisitNum = String(self.myVisitNum)  // 유저의 방문수 받아와 저장 (String)
        let myVisitNumLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = "나는 이 가게를 " + myvisitNum + "번째 방문했어요"
            label.font = UIFont.boldSystemFont(ofSize: 12)
            return label
        }()
        
        tierView.addSubview(tierImageView)
        tierView.addSubview(tierNameLabel)
        tierView.addSubview(myVisitNumLabel)
        
        tierImageView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalTo(tierView.snp.centerY)
        }
        tierNameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(tierImageView.snp.trailing).offset(10)
        }
        myVisitNumLabel.snp.makeConstraints{
            $0.leading.equalTo(tierNameLabel)
            $0.top.equalTo(tierNameLabel.snp.bottom)
        }
        
        scrollView.addSubview(tierView)
        tierView.snp.makeConstraints{
            $0.top.equalTo(numListView.snp.bottom)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide)
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
        
        scrollView.addSubview(heartView)
        heartView.snp.makeConstraints{
            $0.top.equalTo(tierView)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 2.5 / 10)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func heartButtonDidTap(_ sender: UIButton){
        print("heart button tap")
        if(sender.tintColor == .lightGray) { sender.tintColor = .red }
        else { sender.tintColor = .lightGray }
    }
    
    // MARK: storeImageView setting
    
    private func storeImagecollectionViewSetting(){
        
        storeImageView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            view.backgroundColor = .white
            return view
        }()
        
        scrollView.addSubview(storeImageView)
        storeImageView.snp.makeConstraints{
            $0.top.equalTo(tierView.snp.bottom)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            if storeImages.count == 0 {
                $0.height.equalTo(0)
            } else {
                $0.height.equalTo(120)
            }
        }
        
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        
        storeImageCollectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: "storeImageCell")
        
        storeImageView.addSubview(storeImageCollectionView)
        storeImageCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(storeImageView)
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
        
        scrollView.addSubview(recommendItemView)
        recommendItemView.snp.makeConstraints{
            $0.top.equalTo(storeImageCollectionView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            if recommendItemImages.count == 0 {
                $0.height.equalTo(90)
            }
            else if recommendItemImages.count == 1 {
                $0.height.equalTo(75)
            }
            else {
                $0.height.equalTo(125)
            }
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
            
            // recommendItemcollectionView setting
            
            recommendItemView.addSubview(recommendItemCollectionView)
            recommendItemCollectionView.delegate = self
            recommendItemCollectionView.dataSource = self
            recommendItemCollectionView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCollectionViewCell")
            
            recommendItemCollectionView.snp.makeConstraints{
                $0.top.equalTo(recommendItemImageView.snp.bottom).offset(5)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalToSuperview()
                if recommendItemImages.count == 1 {
                    $0.height.equalTo(0)
                } else {
                    $0.height.equalTo(50)
                }
            }
            
            
            // recommendItemView에 터치 이벤트 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recommendItemViewDidTap(_:)))
            recommendItemView.addGestureRecognizer(tapGesture)

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
    
    // recommendItemView tap gesture 정의
    @objc func recommendItemViewDidTap(_ sender: Any){
        print("recommendItemView tap")
        let vc = RecommendItemViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: top5View setting
    
    private func top5ViewSetting(){
        top5Images = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 단골 이미지 저장
        
        top5View = {
            let top5View = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            top5View.backgroundColor = .white
            return top5View
        }()
        
        scrollView.addSubview(top5View)
        top5View.snp.makeConstraints{
            $0.top.equalTo(recommendItemView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            if top5Images.count != 0 {
                $0.height.equalTo(100)
            }
            else {
                $0.height.equalTo(90)
            }
        }
        top5View.translatesAutoresizingMaskIntoConstraints = false

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
            

            // top5View에 터치 이벤트 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(top5ViewDidTap(_:)))
            top5View.addGestureRecognizer(tapGesture)
            
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
    
    // top5View tap gesture 정의
    @objc func top5ViewDidTap(_ sender: Any){
        print("top5View tap")
        let vc = Top5DetailViewController()
        vc.myTierImage = self.myTierImage
        vc.myTier = self.tierName
        vc.myvisitNum = self.myVisitNum
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: storeInfoView setting
    
    private func storeInfoViewSetting(){
        storeInfoView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            view.backgroundColor = .white
            return view
        }()
        
        scrollView.addSubview(storeInfoView)
        storeInfoView.snp.makeConstraints{
            $0.top.equalTo(top5View.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(115)
        }
        
        storeInfoView.addSubview(storeInfoCollectionView)
        storeInfoCollectionView.delegate = self
        storeInfoCollectionView.dataSource = self
        storeInfoCollectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "storeInfoCollectionViewCell")
        //storeInfoCollectionView.backgroundColor = .red
        
        storeInfoCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(90)
        }
    }
    
    // TODO: 영업시간 더보기 버튼 클랙 액션 추가
    
    func officeHourCollectionViewSetting(){
//        if officeHourBtnState == true {  // true이면 officeHourCollectionView 제거
//            officeHourBtnState = false
//            storeInfoCollectionView.reloadData()
//            //officeHourCollectionView.removeFromSuperview()
//
//        } else {  // 아니면 officeHourCollectionView 추가
//            print("false")
//            storeInfos += ["월요일"]
//            officeHourBtnState = true
//            storeInfoCollectionView.reloadData()
//            print("finish")
//        }
    }
    
    
    // MARK: storeMenuView setting
    
    private func menuViewSetting(){
        
        menuView = {
            let menuView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            menuView.backgroundColor = .white
            return menuView
        }()
        
        scrollView.addSubview(menuView)
        menuView.snp.makeConstraints{
            $0.top.equalTo(storeInfoView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(60 + menus.count * 23)
        }
        
        let titleLabel : UILabel = {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = "메뉴"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return titleLabel
        }()
        
        menuView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "menuCollectionViewCell")
        
        menuView.addSubview(menuCollectionView)
        menuCollectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        // 더보기 버튼
        let menuDetailBtn: UIButton = {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            btn.setTitle("더보기", for: .normal)
            btn.titleLabel?.font = btn.titleLabel?.font.withSize(14)
            btn.setTitleColor(.systemBlue, for: .normal)
            btn.addTarget(self, action: #selector(menuDetailBtnDidTap(_:)), for: .touchUpInside)
            return btn
        }()
        
        menuView.addSubview(menuDetailBtn)
        menuDetailBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func menuDetailBtnDidTap(_ sender: Any){
        print("menuDetail button tap")
        let vc = MenuDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: reviewView setting
    
    private func reviewViewSetting(){
        reviewView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            view.backgroundColor = .white
            return view
        }()
        
        scrollView.addSubview(reviewView)
        reviewView.snp.makeConstraints{
            $0.top.equalTo(menuView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(60 + reviews.count/4 * 45)
        }
        
        let titleLabel : UILabel = {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = "우리 동네 리뷰"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return titleLabel
        }()
        
        reviewView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        reviewCollectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "reviewCollectionViewCell")
        
        reviewView.addSubview(reviewCollectionView)
        reviewCollectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        let reviewDetailBtn: UIButton = {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            btn.setTitle("더보기", for: .normal)
            btn.titleLabel?.font = btn.titleLabel?.font.withSize(14)
            btn.setTitleColor(.systemBlue, for: .normal)
            btn.addTarget(self, action: #selector(reviewDetailBtnDidTap(_:)), for: .touchUpInside)
            return btn
        }()
        
        reviewView.addSubview(reviewDetailBtn)
        reviewDetailBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func reviewDetailBtnDidTap(_ sender: Any){
        print("reviewDetail button tap")
        let vc = StoreReviewListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: locationView setting
    
    // TODO: 지도 라이브러리 추가. 지도 우측 상단 버튼 클릭 시 지도 확대
    private func locationViewSetting(){
        locationView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            view.backgroundColor = .white
            return view
        }()
        
        scrollView.addSubview(locationView)
        locationView.snp.makeConstraints{
            $0.top.equalTo(reviewView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        let titleLabel : UILabel = {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = "위치"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return titleLabel
        }()
        
        locationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        let tempMap: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            view.backgroundColor = .lightGray
            return view
        }()
        
        locationView.addSubview(tempMap)
        tempMap.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(135)
        }
    }
    
    
    // MARK: recommendStoreView setting
    
    private func recommendStoreViewSetting(){
        recommendStoreView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            view.backgroundColor = .white
            return view
        }()
        
        scrollView.addSubview(recommendStoreView)
        recommendStoreView.snp.makeConstraints{
            $0.top.equalTo(locationView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.bottom.equalTo(scrollView)
            $0.height.equalTo(190)
        }
        
        let titleLabel : UILabel = {
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            titleLabel.text = "이 가게가 좋았다면 여기는 어때요?"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            return titleLabel
        }()
        
        recommendStoreView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        
        // recommendStorecollectionView setting
        recommendStoreView.addSubview(recommendStoreCollectionView)
        recommendStoreCollectionView.delegate = self
        recommendStoreCollectionView.dataSource = self
        recommendStoreCollectionView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCollectionViewCell")
        
        recommendStoreCollectionView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalToSuperview()
            $0.height.equalTo(110)
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
            return storeInfos.count
        }
        if collectionView == self.menuCollectionView {
            return menus.count
        }
        if collectionView == self.reviewCollectionView {
            return 2
        }
        if collectionView == self.recommendStoreCollectionView {
            return recommendStoreImages.count
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
            
//            if indexPath.row < 3 {
//                cell.iconImageView.image = storeInfoIcons[indexPath.row]
//            } else {cell.iconImageView.image = storeInfoIcons[0]}
//
//            print("22")
            
            cell.iconImageView.image = storeInfoIcons[indexPath.row]
            cell.label.text = storeInfos[indexPath.row]
            
            if(indexPath.row == 2){
                cell.detailBtnSetting()
            }
            
            return cell
        }
        if collectionView == self.menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
            
            if menus != nil && menus.count != 0 {
                cell.menu.text = menus[indexPath.row]
                cell.price.text = prices[indexPath.row]
            }
            
            return cell
        }
        if collectionView == self.reviewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
            
            if reviews != nil && reviews.count != 0 {
                cell.content.text = reviews[indexPath.row*4]
                cell.writer.text = reviews[indexPath.row*4 + 1]
                cell.date.text = reviews[indexPath.row*4 + 2]
                cell.visitNum.text = reviews[indexPath.row*4 + 3] + "번째 방문"
            }
            
            return cell
        }
        if collectionView == self.recommendStoreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCollectionViewCell", for: indexPath) as! CircleCollectionViewCell
            
            let recommendStoreImage = UIImage(named: recommendStoreImages[indexPath.row])
            guard var recommendStoreImage = recommendStoreImage else{
                print("recommendStore image is nil")
                return cell
            }
            recommendStoreImage = self.resizeImage(image: recommendStoreImage, targetSize: CGSize(width: 110, height: 110))!
            cell.imageView.image = recommendStoreImage
            
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
            return CGSize(width: UIScreen.main.bounds.width, height: 30)
        }
        if collectionView == self.menuCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 23)
        }
        if collectionView == self.reviewCollectionView {
            return CGSize(width: UIScreen.main.bounds.width, height: 45)
        }
        if collectionView == self.recommendStoreCollectionView {
            return CGSize(width: 110, height: 110)
        }
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.storeImageCollectionView {
            return 3
        }
        if collectionView == self.recommendItemCollectionView || collectionView == self.top5collectionView || collectionView == self.recommendStoreCollectionView {
            return 15
        }
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.storeImageCollectionView {
            print("storeImage did tap")
            
            let vc = StoreImageDetailViewController()
            vc.index = indexPath.row
            vc.storeImages = self.storeImages
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if collectionView == self.reviewCollectionView {
            print("review did tap")
            let vc = ReviewDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true) // 리뷰 상세 페이지로 이동
        }
        
        if collectionView == self.recommendStoreCollectionView {
            print("store did tap")
            let vc = StoreDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true) // 리뷰 상세 페이지로 이동
        }
    }
    
    // TODO: 버튼 눌렀을 때 영업시간 뷰 추가
    @objc private func detailBtnDidTap(_ sender: Any){
        print("detail button tap")
        //StoreInfoCell().updateCollectionView()
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
