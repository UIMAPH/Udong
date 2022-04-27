//
//  TierInfoViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/28.
//

import Foundation

struct TierInfo {
    let name, info: String?
    let image: UIImage?
}

class TierInfoViewController: UIViewController {
    
    let tierCount : Int = 5
    let tierInfos : [TierInfo] = [
        TierInfo(name: "소울메이트", info: "100번 이상 방문한 소중한 단골이에요!", image: UIImage(named: "new-moon.png")),
        TierInfo(name: "절친한 사이", info: "50번 이상 방문한 귀한 단골이에요!", image: UIImage(named: "new-moon.png")),
        TierInfo(name: "친한 사이", info: "10번 이상 방문한 친한 단골이에요!", image: UIImage(named: "new-moon.png")),
        TierInfo(name: "어색한 사이", info: "5번 이상 방문한 알아가는 단골이에요!", image: UIImage(named: "new-moon.png")),
        TierInfo(name: "모르는 사이", info: "아직 방문한 적 없는 첫 손님이에요!", image: UIImage(named: "new-moon.png"))]
    
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var myView = UIView()
    lazy var collectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarSetting()
        self.displaySetting()
        self.collectionViewSetting()
    }
    
}

extension TierInfoViewController {
    
    // MARK: navigationBar setting
    
    private func navigationBarSetting(){
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtnDidTap(_:)))
        backButtonItem.tintColor = .black
        
        let titleLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = "등급 정보"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView.safeAreaLayoutGuide).offset(-15)
        }
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.titleView = containerView
    }
    
    @objc private func backBtnDidTap(_ sender: Any){
        print("tap back button tabp")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func displaySetting(){
        myView = {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
            myView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
            return myView
        }()
        self.view.addSubview(myView)
        myView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50 + 102 * tierCount + SPACING_FOR_VIEW)
        }
    }
}

extension TierInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func collectionViewSetting(){
        collectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuDetailCollectionViewCell.self, forCellWithReuseIdentifier: "menuDetailCollectionViewCell")

        myView.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(SPACING_FOR_VIEW)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tierCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuDetailCollectionViewCell", for: indexPath) as! MenuDetailCollectionViewCell

        let image = tierInfos[indexPath.row].image
        guard var image = image else{
            print("image is nil")
            return cell
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 70, height: 70))!

        cell.menu.text = tierInfos[indexPath.row].name
        cell.price.text = tierInfos[indexPath.row].info
        cell.imageView.image = image

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(SPACING_FOR_VIEW)
    }
}

