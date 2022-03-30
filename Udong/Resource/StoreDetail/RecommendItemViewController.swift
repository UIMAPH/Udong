//
//  RecommendItemDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/13.
//

import Foundation

class RecommendItemViewController: UIViewController{
    
    var myView = UIView()
    
    let top1Title = ["로컬들이 선택한 ", "\"단무지 맛집\""]
    let top5Title = ["단무지가 맛있어요!", "단무지가 맛있어요!", "단무지가 맛있어요!", "단무지가 맛있어요!", "단무지가 맛있어요!"]
    let top5Image = ["crown.png", "crown.png", "crown.png", "crown.png", "crown.png"]
    let otherImages = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]
    
    var top1View = UIView()
    lazy var mainCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    var otherRecommendView = UIView()
    lazy var otherCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarSetting()
        StoreDetailViewController().numListViewSetting(self.view)
        self.displaySetting()
        self.mainCollectionViewSetting()
        self.otherRecommendViewSetting()
    }
}

extension RecommendItemViewController{
    
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
        self.navigationController?.pushViewController(StoreImageDetailViewController(), animated: true)  // 리뷰 작성 페이지로 수정
    }
}

extension RecommendItemViewController {
    
    private func displaySetting(){
        myView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
            return myView
        }()
        self.view.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // MARK: top1View setting
        
        top1View = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = .white
            return myView
        }()
        
        myView.addSubview(top1View)
        top1View.snp.makeConstraints{
            $0.top.equalToSuperview().offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        let image = UIImage(named: top5Image[0])
        guard var image = image else{
            print("image is nil")
            return
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))!
        
        let iconImageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            imageView.image = image
            return imageView
        }()
        let label1: UILabel = {
            let label = UILabel()
            label.text = top1Title[0]
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        let label2: UILabel = {
            let label = UILabel()
            label.text = top1Title[1]
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        
        top1View.addSubview(iconImageView)
        top1View.addSubview(label1)
        top1View.addSubview(label2)
        
        iconImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        label1.snp.makeConstraints{
            $0.top.equalTo(iconImageView).offset(7)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        label2.snp.makeConstraints{
            $0.top.equalTo(label1.snp.bottom)
            $0.leading.equalTo(label1)
        }
    }
    
    // MARK: maincollectionView setting
    
    private func mainCollectionViewSetting(){
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        
        myView.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints{
            $0.top.equalTo(top1View.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60*5 + 20)
        }
    }
    
    // MARK: otherRecommendView setting
    
    private func otherRecommendViewSetting(){
        otherRecommendView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = .white
            return myView
        }()
        
        myView.addSubview(otherRecommendView)
        otherRecommendView.snp.makeConstraints{
            $0.top.equalTo(mainCollectionView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "다른 추천항목"
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        
        otherRecommendView.addSubview(label)
        label.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        
        // otherCollectionView setting
        otherCollectionView.dataSource = self
        otherCollectionView.delegate = self
        otherCollectionView.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: "circleCell")
        
        otherRecommendView.addSubview(otherCollectionView)
        otherCollectionView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(15)
            $0.leading.equalTo(label)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}


// MARK: collectionView setting

extension RecommendItemViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainCollectionView {
            return top5Title.count
        }
        if collectionView == self.otherCollectionView {
            return otherImages.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.mainCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! StoreInfoCollectionViewCell
            
            let image = UIImage(named: top5Image[indexPath.row])
            guard var image = image else{
                print("image is nil")
                return cell
            }
            image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))!
                
            cell.iconImageView.image = image
            cell.label.text = "\"" + top5Title[indexPath.row] + "\""
            cell.label.font = UIFont.boldSystemFont(ofSize: 15)
            
            return cell
        }
        
        if collectionView == self.otherCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "circleCell", for: indexPath) as! CircleCollectionViewCell
            
            let recommendItemImage = UIImage(named: otherImages[indexPath.row])
            guard var recommendItemImage = recommendItemImage else{
                print("recommendItem image is nil")
                return cell
            }
            recommendItemImage = StoreDetailViewController().resizeImage(image: recommendItemImage, targetSize: CGSize(width: 50, height: 50))!
            cell.imageView.image = recommendItemImage
            
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mainCollectionView{
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        }
        if collectionView == self.otherCollectionView{
            return CGSize(width: 50, height: 50)
        }
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.mainCollectionView{
            return 3
        }
        if collectionView == self.otherCollectionView{
            return 10
        }
        return 3
    }
    
    
}
