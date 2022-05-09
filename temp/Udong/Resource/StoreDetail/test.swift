//
//  test.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/19.
//

import Foundation
import UIKit

// TODO: 버튼 눌렀을 때 view 변화 구현
class test: UIViewController {
    
    let storeInfoIcons = [UIImage(systemName: "mappin.and.ellipse"), UIImage(systemName: "phone.fill"), UIImage(systemName: "clock")]
    var storeInfos = ["주소", "전화번호", "영업시간"]  /// 가게 주소, 전화번호, 영업시간 저장
    //let officeHours = ["월요일", "월요일", "월요일", "월요일", "월요일", "월요일", "월요일"]
    var officeHours = [""]
    
    var scrollView = UIScrollView()
    var storeInfoView = UIView()
    
    var btnState: Bool = false
    
    lazy var storeInfoCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    lazy var detailInfoCollectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.scrollViewSetting()
        self.storeInfoViewSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.storeInfoViewSetting()
    }
    
    private func scrollViewSetting(){
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
    }
}

extension test{
    
    private func storeInfoViewSetting(){
        storeInfoView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            view.backgroundColor = .yellow
            return view
        }()
        
        scrollView.addSubview(storeInfoView)
        storeInfoView.snp.makeConstraints{
            $0.top.equalTo(scrollView.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
        
        storeInfoView.addSubview(storeInfoCollectionView)
        storeInfoCollectionView.delegate = self
        storeInfoCollectionView.dataSource = self
        storeInfoCollectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "storeInfoCollectionViewCell")
        //storeInfoCollectionView.backgroundColor = .red
        
        storeInfoCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            //$0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        //if(btnState){
            print(btnState)
            scrollView.addSubview(detailInfoCollectionView)
            detailInfoCollectionView.delegate = self
            detailInfoCollectionView.dataSource = self
            detailInfoCollectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "storeInfoCollectionViewCell")
            
            detailInfoCollectionView.snp.makeConstraints{
                $0.top.equalTo(storeInfoCollectionView.snp.bottom).offset(10)
                //$0.bottom.equalToSuperview().offset(-10)
                $0.leading.trailing.equalTo(scrollView.safeAreaLayoutGuide)
                $0.height.equalTo(150)
            }
        //}
    }
    
    func detailBtnDidTap(){
        //storeInfos += officeHours
        btnState = true
        officeHours = ["월요일", "월요일", "월요일", "월요일", "월요일", "월요일", "월요일"]
        detailInfoCollectionView.reloadData()
        
        viewWillAppear(true)
        self.view.setNeedsLayout()
        self.scrollView.setNeedsLayout()
    }
}

extension test: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.storeInfoCollectionView{
            return storeInfos.count
        }
        if collectionView == self.detailInfoCollectionView{
            return officeHours.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeInfoCollectionViewCell", for: indexPath) as! StoreInfoCollectionViewCell
        
        if collectionView == self.storeInfoCollectionView {
            cell.iconImageView.image = storeInfoIcons[indexPath.row]
            cell.label.text = storeInfos[indexPath.row]
            
            if(indexPath.row == 2){
                cell.detailBtnSetting()
            }
        }
        else {
            cell.label.text = officeHours[indexPath.row]
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 30)
    }
}
