//
//  ReviewDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/21.
//

import Foundation

struct UserInfo {
    let name, title, tier: String?
    let reviewCount, visitCount: Int
}

class ReviewDetailViewController: UIViewController {
    
    let userInfo = UserInfo(name: "이름", title: "칭호", tier: "등급", reviewCount: 0, visitCount: 0)
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var numListView = UIView()
    var userInfoView = UIView()
    lazy var recommendItemCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    lazy var imageCollectionView: UICollectionView = {
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
            $0.top.equalTo(numListView.snp.bottom).offset(SPACING_FOR_VIEW)
            $0.width.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
    }
    
}
