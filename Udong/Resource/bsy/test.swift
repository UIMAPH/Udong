//
//  test.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/19.
//

import Foundation

class test: UIViewController {
    
    var scrollView = UIScrollView()
    var numListView = UIView()
    var tierView = UIView()
    var heartView = UIView()
    lazy var storeImageCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    let recommendItem = "단무지 맛집"  // 추천항목 저장
    var recommendItemImages: [String] = []  // 추천항목 이미지 저장
    var recommendItemView = UIView()
    lazy var recommendItemCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.displaySetting()
        self.storeImagecollectionViewSetting()
        self.displaySetting2()
    }
    
    private func displaySetting(){
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.backgroundColor = .white
            //scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
        }()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
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
            tierImage = StoreDetailViewController().resizeImage(image: tierImage, targetSize: CGSize(width: 30, height: 30))!
            
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
        
        scrollView.addSubview(tierView)
        tierView.snp.makeConstraints{
            $0.top.equalTo(numListView.snp.bottom).offset(10)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 7.5 / 10)
            $0.height.equalTo(50)
        }
        
        
        
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
            $0.top.equalTo(numListView.snp.bottom).offset(10)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.width.equalTo(UIScreen.main.bounds.width * 2.5 / 10)
            $0.height.equalTo(50)
        }
    }
}


extension test: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeImageCell", for: indexPath) as! StoreImageCell
        
        let storeImage = UIImage(named: "rectangle.png")
        guard var storeImage = storeImage else{
            print("store image is nil")
            return cell
        }
        storeImage = StoreDetailViewController().resizeImage(image: storeImage, targetSize: CGSize(width: 100, height: 100))!
        cell.storeImageView.image = storeImage
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    private func storeImagecollectionViewSetting(){
        
        storeImageCollectionView.delegate = self
        storeImageCollectionView.dataSource = self
        
        storeImageCollectionView.register(StoreImageCell.self, forCellWithReuseIdentifier: "storeImageCell")
        
        scrollView.addSubview(storeImageCollectionView)
        //collectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        storeImageCollectionView.snp.makeConstraints{
            $0.top.equalTo(tierView.snp.bottom)
            $0.leading.equalTo(scrollView.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            //$0.width.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        
    }
    
}



extension test{
    
    private func displaySetting2(){
        
        recommendItemImages = ["new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png", "new-moon.png"]  // 추천키워드 이미지 저장

        recommendItemView = {
            let recommendItemView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
            recommendItemView.backgroundColor = .white
            return recommendItemView
        }()
        
        scrollView.addSubview(recommendItemView)
        recommendItemView.snp.makeConstraints{
            $0.top.equalTo(storeImageCollectionView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
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
        
        
        
        let label2: UILabel = {
            let label = UILabel()
            label.text = "scroll bottom"
            label.backgroundColor = .red
            //label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        scrollView.addSubview(label2)
        label2.snp.makeConstraints{
            $0.top.equalTo(scrollView).offset(1000)
            $0.leading.bottom.equalTo(scrollView)
        }
    }
    
    
    @objc private func heartButtonDidTap(_ sender: UIButton){
        print("heart button tap")
        if(sender.tintColor == .lightGray) { sender.tintColor = .red }
        else { sender.tintColor = .lightGray }
    }
    
    @objc func recommendItemViewDidTap(_ sender: Any){
        print("recommendItemView tap")
        self.navigationController?.pushViewController(RecommendItemDetailViewController(), animated: true)
    }
}
