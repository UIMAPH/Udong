//
//  MenuDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/21.
//

import Foundation
import UIKit

// TODO: Menu에 이미지 추가
struct Menu: Codable {
    let id: Int?
    let item, price: String?
}

// TODO: 사진 없을 경우 제외하고 보여줌
class MenuListViewController: UIViewController {
    
    let menuNum : Int = 10
    let menus : [Menu] = [Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원"), Menu(id: 0, item: "김치치즈가츠동", price: "7000원")]
    let menuImages : [String] = ["rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png", "rectangle.png"]
    
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

extension MenuListViewController {
    
    // MARK: navigationBar setting
    
    private func navigationBarSetting(){
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtnDidTap(_:)))
        backButtonItem.tintColor = .black
        
        let titleLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = "메뉴"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        let numLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = String(menuNum)
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .systemBlue
            return label
        }()
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(numLabel)
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalTo(containerView)
        }
        numLabel.snp.makeConstraints{
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.top.equalTo(titleLabel)
        }

        navigationItem.leftBarButtonItem = backButtonItem
        self.navigationController?.navigationBar.addSubview(containerView)
        containerView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(50)
        }
    }
    
    @objc private func backBtnDidTap(_ sender: Any){
        print("tap back button tabp")
        containerView.removeFromSuperview()
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
            $0.height.equalTo(102 * menuNum + SPACING_FOR_VIEW)
        }
    }
}

extension MenuListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return menuNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuDetailCollectionViewCell", for: indexPath) as! MenuDetailCollectionViewCell

        let image = UIImage(named: menuImages[indexPath.row])
        guard var image = image else{
            print("image is nil")
            return cell
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 70, height: 70))!

        cell.menu.text = menus[indexPath.row].item
        cell.price.text = menus[indexPath.row].price
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
