//
//  StoreImageDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/10.
//

import Foundation

/// ImageSlideshow 라이브러리 이용
/// https://jellysong.tistory.com/74

// TODO: 이미지 Label Indicator - imageslideshow 이용하거나 직접 기능 구현

class StoreImageDetailViewController: UIViewController{
    
    //var storeImages: [String] = []
    var storeImages: [String] = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]
    var index: Int = 0
    var preOffset: Double = 0.0
    
    var numListView = UIView()
    lazy var storeImageCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarSetting()
        self.numListViewSetting()
        self.collectionViewSetting()
        self.displaySetting()
        
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension StoreImageDetailViewController{
    
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

// MARK: display setting

extension StoreImageDetailViewController{
    
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
        
        self.view.addSubview(numListView)
        numListView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(20)
        }
    }
    
    private func displaySetting(){
        self.view.backgroundColor = .white
        
        let indexLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        indexLabel.text = String(index) + "/" + String(storeImages.count)
        
        self.view.addSubview(indexLabel)
        indexLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
    }
}

// MARK: collectionView setting

extension StoreImageDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private func collectionViewSetting(){
        self.view.addSubview(storeImageCollectionView)
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        storeImageCollectionView.snp.makeConstraints{
            $0.top.equalTo(numListView.snp.bottom).offset(10) 
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        storeImageCollectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: "storeImageCell")
        
        // collectionView paging 설정
        storeImageCollectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeImageCell", for: indexPath) as! StoreImageCell
        
        cell.backgroundColor = .red
        
        let storeImage = UIImage(named: storeImages[indexPath.row])
        guard var storeImage = storeImage else{
            print("store image is nil")
            return cell
        }
        storeImage = StoreDetailViewController().resizeImage(image: storeImage, targetSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))!
        cell.storeImageView.image = storeImage
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension StoreImageDetailViewController: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x < preOffset && index > 1 {
            index-=1
        }
        else if scrollView.contentOffset.x > preOffset && index < 10{
            index+=1
        }
        preOffset = scrollView.contentOffset.x
        
        print(index)
    }
}
