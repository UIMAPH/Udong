//
//  Top5DetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/17.
//

import Foundation

// TODO: 티어 아이콘 주위 테두리

class Top5DetailViewController: UIViewController{
    
    var myTierImage: UIImage? = UIImage()
    var myTier: String = ""
    var myvisitNum: Int = 0
    
    let top5Colors: [UIColor] = [UIColor(red: 0xE4, green: 0x0E, blue: 0x0E),
                                UIColor(red: 0xF4, green: 0x5D, blue: 0x5D),
                                UIColor(red: 0xFD, green: 0xB2, blue: 0xB2),
                                UIColor(red: 0xFA, green: 0xCD, blue: 0xCD),
                                UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)]
    let top5Image = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]
    let top5Name = ["이름", "이름", "이름", "이름", "이름"]
    let top5Title = ["칭호", "칭호", "칭호", "칭호", "칭호"]
    let top5Tier = ["등급", "등급", "등급", "등급", "등급"]
    let top5ReviewNum = [0, 0, 0, 0, 0]
    let top5VisitNum = [0, 0, 0, 0, 0]
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var numListView = UIView()
    var myTierView = UIView()
    var titleView = UIView()  // 이 가게 단골들
    lazy var top5CollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarSetting()
        self.numListViewSetting()
        self.displaySetting()
        self.collectionViewSetting()
    }
}

extension Top5DetailViewController{
    
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

extension Top5DetailViewController {
    
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
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // MARK: top1View setting
        
        myTierView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = .white
            return myView
        }()
        
        scrollView.addSubview(myTierView)
        myTierView.snp.makeConstraints{
            $0.top.equalTo(numListView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
        
        // 티어 이미지 설정
        guard var myTierImage = myTierImage else{
            print("image is nil")
            return
        }
        myTierImage = StoreDetailViewController().resizeImage(image: myTierImage, targetSize: CGSize(width: 90, height: 90))!
        
        let myTierImageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
            imageView.image = myTierImage
            imageView.layer.cornerRadius = imageView.frame.height/2
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = top5Colors[0].cgColor
            return imageView
        }()
        let myTierLabel: UILabel = {
            let label = UILabel()
            label.text = myTier
            label.font = UIFont.boldSystemFont(ofSize: 22)
            return label
        }()
        let myVisitNumLabel: UILabel = {
            let label = UILabel()
            label.text = "나는 이 가게를 " + String(myvisitNum) + "번 방문했어요"
            label.font = UIFont.boldSystemFont(ofSize: 15)
            return label
        }()
        
        myTierView.addSubview(myTierImageView)
        myTierView.addSubview(myTierLabel)
        myTierView.addSubview(myVisitNumLabel)
        
        myTierImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        myTierLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-15)
            $0.leading.equalTo(myTierImageView.snp.trailing).offset(20)
        }
        myVisitNumLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(15)
            $0.leading.equalTo(myTierLabel)
        }
        
        // MARK: titleView setting
        titleView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = .white
            return myView
        }()
        
        scrollView.addSubview(titleView)
        titleView.snp.makeConstraints{
            $0.top.equalTo(myTierView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(35)
        }
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "이 가게 단골들"
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        titleView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
}


// MARK: collectionView setting

extension Top5DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private func collectionViewSetting(){
        top5CollectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        top5CollectionView.dataSource = self
        top5CollectionView.delegate = self
        top5CollectionView.register(Top5CollectionViewCell.self, forCellWithReuseIdentifier: "top5CollectionViewCell")

        scrollView.addSubview(top5CollectionView)
        top5CollectionView.snp.makeConstraints{
            $0.top.equalTo(titleView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(100 * top5Image.count + 20)
            $0.bottom.equalTo(scrollView)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return top5Image.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "top5CollectionViewCell", for: indexPath) as! Top5CollectionViewCell

        let image = UIImage(named: top5Image[indexPath.row])
        guard var image = image else{
            print("image is nil")
            return cell
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 60, height: 60))!

        cell.iconImageView.image = image
        cell.ranking.text = String(indexPath.row+1) + "등"
        cell.name.text = top5Name[indexPath.row]
        cell.title.text = "\"" + top5Title[indexPath.row] + "\""
        cell.tier.text = top5Tier[indexPath.row]
        cell.numList.text = "리뷰수 " + String(top5ReviewNum[indexPath.row]) + " 방문수 " + String(top5VisitNum[indexPath.row])
        
        cell.iconImageView.layer.borderColor = top5Colors[indexPath.row].cgColor

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(SPACING_FOR_VIEW)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("user did tap")
        let vc = UserReviewListViewController()
        self.navigationController?.pushViewController(vc, animated: true) // 해당 유저의 리뷰 리스트로 이동
    }

}
