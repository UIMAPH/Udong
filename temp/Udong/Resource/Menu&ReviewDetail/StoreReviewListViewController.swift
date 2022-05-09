//
//  ReviewDetailViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/21.
//

import Foundation
import UIKit

struct Review {
    let content, writer: String?
    let date: String?
    let visitCount: Int
    let image: UIImage?
    let likeCount: Int
}

// TODO: 이전 페이지에서 가게의 리뷰 정보 넘겨받기
class StoreReviewListViewController: UIViewController {
    
    let reviewCount : Int = 5
    let reviews : [Review] = [Review(content: "내용입니다내용입니다내용입니다내용입니다내용입니다내용입니다", writer: "작성자", date: "22.04.28", visitCount: 0, image: UIImage(named: "rectangle.png"), likeCount: 0), Review(content: "내용입니다내용입니다내용입니다내용입니다내용입니다내용입니다", writer: "작성자", date: "22.04.28", visitCount: 0, image: UIImage(named: "rectangle.png"), likeCount: 0), Review(content: "내용입니다내용입니다내용입니다내용입니다내용입니다내용입니다", writer: "작성자", date: "22.04.28", visitCount: 0, image: UIImage(named: "rectangle.png"), likeCount: 0), Review(content: "내용입니다내용입니다내용입니다내용입니다내용입니다내용입니다", writer: "작성자", date: "22.04.28", visitCount: 0, image: UIImage(named: "rectangle.png"), likeCount: 0), Review(content: "내용입니다내용입니다내용입니다내용입니다내용입니다내용입니다", writer: "작성자", date: "22.04.28", visitCount: 0, image: UIImage(named: "rectangle.png"), likeCount: 0)]
    
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

extension StoreReviewListViewController {
    
    // MARK: navigationBar setting
    
    private func navigationBarSetting(){
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backBtnDidTap(_:)))
        backButtonItem.tintColor = .black
        
        let titleLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = "우리 동네 리뷰"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        let numLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = String(reviewCount)
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
            $0.height.equalTo(102 * reviewCount + SPACING_FOR_VIEW)
        }
    }
}

extension StoreReviewListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func collectionViewSetting(){
        collectionView.backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReviewDetailCollectionViewCell.self, forCellWithReuseIdentifier: "reviewDetailCollectionViewCell")

        myView.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(SPACING_FOR_VIEW)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewDetailCollectionViewCell", for: indexPath) as! ReviewDetailCollectionViewCell

        let image = reviews[indexPath.row].image
        guard var image = image else{
            print("image is nil")
            return cell
        }
        image = StoreDetailViewController().resizeImage(image: image, targetSize: CGSize(width: 70, height: 70))!

        cell.content.text = reviews[indexPath.row].content
        cell.writer.text = reviews[indexPath.row].writer
        cell.date.text = reviews[indexPath.row].date
        cell.visitCount.text = String(reviews[indexPath.row].visitCount) + "번째 방문"
        cell.likeCount.text = String(reviews[indexPath.row].likeCount)
        cell.imageView.image = image

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(SPACING_FOR_VIEW)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("review did tap")
        containerView.removeFromSuperview()
        let vc = ReviewDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true) // 리뷰 상세 페이지로 이동
    }
}

