//
//  TierInfoViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/04/28.
//

import Foundation
import UIKit

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
    let tierColor: [UIColor] = [UIColor(red: 0xE4, green: 0x0E, blue: 0x0E),
                                UIColor(red: 0xF4, green: 0x5D, blue: 0x5D),
                                UIColor(red: 0xFD, green: 0xB2, blue: 0xB2),
                                UIColor(red: 0xFA, green: 0xCD, blue: 0xCD),
                                UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)]
    
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    var spacingView = UIView()
    var infoLabel = UILabel()
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
        spacingView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat(SPACING_FOR_VIEW)))
            view.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
            return view
        }()
        self.view.addSubview(spacingView)
        spacingView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SPACING_FOR_VIEW)
        }
        
        infoLabel = {
            let label = UILabel()
            label.text = "단골 등급은 방문횟수에 따라 결정돼요! 내가 좋아하는 가게에 여러번 방문하고 단골이 되어보세요!"
            label.textColor = .lightGray
            label.font = label.font.withSize(14)
            label.numberOfLines = 0
            return label
        }()
        
        self.view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints{
            $0.top.equalTo(spacingView)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.height.equalTo(60)
        }
    }
}

extension TierInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func collectionViewSetting(){
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TierInfoCollectionViewCell.self, forCellWithReuseIdentifier: "tierInfoCollectionViewCell")

        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.top.equalTo(infoLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(infoLabel)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tierCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tierInfoCollectionViewCell", for: indexPath) as! TierInfoCollectionViewCell

        let image = tierInfos[indexPath.row].image
        guard var image = image else{
            print("image is nil")
            return cell
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 60, height: 60))!

        cell.tierNmae.text = tierInfos[indexPath.row].name
        cell.info.text = tierInfos[indexPath.row].info
        cell.imageView.image = image
        cell.imageView.layer.borderColor = tierColor[indexPath.row].cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-30, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

