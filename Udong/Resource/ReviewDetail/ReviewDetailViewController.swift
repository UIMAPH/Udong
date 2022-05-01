//
//  ReviewDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/21.
//

import Foundation

// TODO: imageIndex 1이랑 10에서 오류잡기
// TODO: 리뷰 최대 글자수 30*10 = 300자 정도

struct UserInfo {
    let name, title, tier: String?
    let reviewCount, visitCount: Int
}

struct RecommendItem{
    let icon: UIImage?
    let itemLabel: String?
}

class ReviewDetailViewController: UIViewController {
    
    let userInfo = UserInfo(name: "이름", title: "칭호", tier: "등급", reviewCount: 0, visitCount: 0)
    let recommendItems: [RecommendItem] = [
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!"),
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!"),
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!"),
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!"),
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!"),
        RecommendItem(icon: UIImage(named: "crown.png"), itemLabel: "딸기가 맛있어요!")]
    //var reviewImages: [UIImage] = []
    var reviewImages: [String] = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]
    var imageIndex: Int = 0
    var preOffset: Double = 0.0
    var reviewText = "인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다. 인하대 가메이는 정말 최고의 맛입니다."
    var heartCount = 0
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var numListView = UIView()
    var spacingView1 = UIView()
    var userInfoView = UIView()
    var spacingView2 = UIView()
    lazy var recommendItemCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    lazy var imageCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    var textView = UIView()
    var likeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarSetting()
        self.numListViewSetting()
        self.displaySetting()
        self.collectionViewSetting()
        self.displaySetting2()
    }
}

extension ReviewDetailViewController{
    
    // MARK: navigationBar setting
    
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

extension ReviewDetailViewController {
    
    // MARK: numListView setting
    
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
            $0.height.equalTo(30)
        }
    }
    
    // MARK: display setting
    
    private func displaySetting(){
        
        // scrollView setting
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // spacingView setting
        spacingView1 = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(SPACING_FOR_VIEW)))
            view.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
            return view
        }()
        scrollView.addSubview(spacingView1)
        spacingView1.snp.makeConstraints{
            $0.top.equalTo(numListView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SPACING_FOR_VIEW)
        }
        
        // MARK: userInfoView setting
        userInfoView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            myView.backgroundColor = .white
            
            let iconImageView: UIImageView = {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                let image = UIImage(named: "new-moon.png")
                guard var image = image else{
                    print("image is nil")
                    return UIImageView()
                }
                image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 60, height: 60))!
                imageView.image = image
                
                imageView.layer.cornerRadius = imageView.frame.height/2
                imageView.clipsToBounds = true
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.layer.borderWidth = 3
                imageView.layer.borderColor = UIColor(red: 0xE4, green: 0x0E, blue: 0x0E).cgColor
                
                return imageView
            }()
            
            myView.addSubview(iconImageView)
            iconImageView.snp.makeConstraints{
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(15)
            }
            
            let name: UILabel = {
                let label = UILabel()
                label.text = userInfo.name
                label.font = UIFont.boldSystemFont(ofSize: 14)
                return label
            }()
            let title: UILabel = {  // 칭호
                let label = UILabel()
                label.text = "\"" + userInfo.title! + "\""
                label.font = UIFont.boldSystemFont(ofSize: 14)
                return label
            }()
            let tier: UILabel = {
                let label = UILabel()
                label.text = userInfo.tier
                label.font = UIFont.boldSystemFont(ofSize: 14)
                return label
            }()
            let numList: UILabel = {
                let label = UILabel()
                label.text = "리뷰수 " + String(userInfo.reviewCount) + " 방문수 " + String(userInfo.visitCount)
                label.font = UIFont.boldSystemFont(ofSize: 14)
                return label
            }()
            
            myView.addSubview(name)
            myView.addSubview(title)
            myView.addSubview(tier)
            myView.addSubview(numList)

            name.snp.makeConstraints{
                $0.centerY.equalToSuperview().offset(-20)
                $0.leading.equalTo(iconImageView.snp.trailing).offset(15)
            }
            title.snp.makeConstraints{
                $0.centerY.equalTo(name)
                $0.leading.equalTo(name.snp.trailing).offset(30)
            }
            tier.snp.makeConstraints{
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(name)
            }
            numList.snp.makeConstraints{
                $0.centerY.equalToSuperview().offset(20)
                $0.leading.equalTo(name)
            }
            
            return myView
        }()
        
        scrollView.addSubview(userInfoView)
        userInfoView.snp.makeConstraints{
            $0.top.equalTo(spacingView1.snp.bottom)
            $0.width.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        // spacingView setting
        spacingView2 = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(SPACING_FOR_VIEW)))
            view.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
            return view
        }()
        scrollView.addSubview(spacingView2)
        spacingView2.snp.makeConstraints{
            $0.top.equalTo(userInfoView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SPACING_FOR_VIEW)
        }
    }
}

extension ReviewDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func collectionViewSetting(){
        recommendItemCollectionView.backgroundColor = .white
        recommendItemCollectionView.dataSource = self
        recommendItemCollectionView.delegate = self
        recommendItemCollectionView.register(RecommendItemCollectionViewCell.self, forCellWithReuseIdentifier: "recommendItemCell")

        scrollView.addSubview(recommendItemCollectionView)
        recommendItemCollectionView.snp.makeConstraints{
            $0.top.equalTo(spacingView2.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-10)
            if recommendItems.count % 2 == 0 {
                $0.height.equalTo(recommendItems.count/2 * 55)
            } else {
                $0.height.equalTo((recommendItems.count/2+1) * 55)
            }
        }
        
        // imageCollectionView setting
        scrollView.addSubview(imageCollectionView)
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.snp.makeConstraints{
            $0.top.equalTo(recommendItemCollectionView.snp.bottom)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        imageCollectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: "imageCell")
        imageCollectionView.isPagingEnabled = true  // collectionView paging 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.recommendItemCollectionView{
            return recommendItems.count
        }
        if collectionView == self.imageCollectionView{
            return reviewImages.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.recommendItemCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendItemCell", for: indexPath) as! RecommendItemCollectionViewCell

            let image = recommendItems[indexPath.row].icon
            guard var image = image else{
                print("image is nil")
                return cell
            }
            image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))!
            cell.itemLabel.text = recommendItems[indexPath.row].itemLabel
            cell.iconImageView.image = image
            
            return cell
        }
        if collectionView == self.imageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! StoreImageCell

            let image = UIImage(named: reviewImages[indexPath.row])
            guard var image = image else{
                print("image is nil")
                return cell
            }
            image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: UIScreen.main.bounds.width, height: 200))!
            cell.storeImageView.image = image
            cell.backgroundColor = .lightGray
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendItemCell", for: indexPath) as! RecommendItemCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.recommendItemCollectionView{
            return CGSize(width: UIScreen.main.bounds.width/2 - 15, height: 45)
        }
        if collectionView == self.imageCollectionView{
            return CGSize(width: UIScreen.main.bounds.width, height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.imageCollectionView{
            return 0
        }
        return 10
    }
}

extension ReviewDetailViewController {
    private func displaySetting2(){
        // imageIndex 설정
        let indexLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = String(imageIndex) + "/" + String(reviewImages.count)
            label.font = label.font.withSize(12)
            return label
        }()
        scrollView.addSubview(indexLabel)
        indexLabel.snp.makeConstraints{
            $0.top.equalTo(imageCollectionView).offset(12)
            $0.centerX.equalTo(scrollView)
        }
        
        // MARK: textView setting
        textView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            view.layer.borderWidth = 4
            view.layer.borderColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF).cgColor
            view.layer.cornerRadius = 10
            
            let text: UILabel = {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                label.text = reviewText
                label.font = label.font.withSize(16)
                return label
            }()
            view.addSubview(text)
            text.snp.makeConstraints{
                $0.top.leading.equalToSuperview().offset(10)
                $0.trailing.equalToSuperview().offset(-10)
            }
            text.numberOfLines = 0
            
            return view
        }()
        scrollView.addSubview(textView)
        textView.snp.makeConstraints{
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(210)
        }
        
        // MARK: likeView setting
        
        likeView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

            let likeLabel: UILabel = {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                label.text = "이 리뷰가 좋았다면?"
                label.font = UIFont.boldSystemFont(ofSize: 16)
                return label
            }()
            view.addSubview(likeLabel)
            likeLabel.snp.makeConstraints{
                $0.top.leading.equalToSuperview().offset(10)
            }
            
            let heartButton: UIButton = {
                let heartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                let heartImage = UIImage(systemName: "suit.heart.fill")
                //heartImage = self.resizeImage(image: heartImage!, targetSize: CGSize(width: 30, height: 30))!
                heartButton.setImage(heartImage, for: .normal)
                heartButton.addTarget(self, action: #selector(heartButtonDidTap(_:)), for: .touchUpInside)
                heartButton.tintColor = .lightGray
                return heartButton
            }()
            
            let heartCount: UILabel = {
                let heartLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
                heartLabel.text = "0"
                heartLabel.font = UIFont.boldSystemFont(ofSize: 16)
                return heartLabel
            }()
            
            view.addSubview(heartButton)
            view.addSubview(heartCount)
            
            heartButton.snp.makeConstraints{
                $0.top.equalTo(likeLabel.snp.bottom).offset(5)
                $0.leading.equalTo(likeLabel)
            }
            heartCount.snp.makeConstraints{
                $0.top.equalTo(heartButton)
                $0.leading.equalTo(heartButton.snp.trailing).offset(5)
            }
            
            return view
        }()
    
        scrollView.addSubview(likeView)
        likeView.snp.makeConstraints{
            $0.top.equalTo(textView.snp.bottom)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(5)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide).offset(-5)
            $0.bottom.equalTo(scrollView)
            $0.height.equalTo(70)
        }
    }
    
    @objc private func heartButtonDidTap(_ sender: UIButton){
        print("heart button tap")
        if(sender.tintColor == .lightGray) {
            sender.tintColor = .red
            heartCount += 1
        }
        else {
            sender.tintColor = .lightGray
            heartCount -= 1
        }
    }
}

extension ReviewDetailViewController: UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x < preOffset && imageIndex > 1 {
            imageIndex-=1
        }
        else if scrollView.contentOffset.x > preOffset && imageIndex < 10{
            imageIndex+=1
        }
        preOffset = scrollView.contentOffset.x
        print(imageIndex)
    }
}
