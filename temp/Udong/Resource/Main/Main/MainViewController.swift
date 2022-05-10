//
//  MainViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/05.
//

import Foundation
import UIKit


import SnapKit

class MainViewController: UIViewController {
    
    var titleText: [String]?
    let LARGE_CELL = "MainCollectionViewLargeCell"
    let SMALL_CELL = "MainCollectionViewSmallCell"
    let LONG_CELL = "MainCollectionViewLongCell"
    
    var currentArea = UILabel()
    var leftBarView = UIView()
    //var dropDown = DropDown()
    var statusBackView: UIView = {
        let statusBackView = UIView()
        statusBackView.backgroundColor = .mainblue
        
        return statusBackView
    }()
    
    lazy var categoryPageViewController: UIPageViewController = {
        let categoryPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return categoryPageViewController
    }()
    
    lazy var imageScrollPageControll: UIPageControl = {
        let imageScrollPageControll = UIPageControl()
        imageScrollPageControll.numberOfPages = 10
        imageScrollPageControll.currentPage = 0
        imageScrollPageControll.pageIndicatorTintColor = .white
        imageScrollPageControll.currentPageIndicatorTintColor = .mainblue
        
        return imageScrollPageControll
    }()
    
    lazy var imageScrollView: UIScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.isScrollEnabled = true
        imageScrollView.isPagingEnabled = true
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageScrollView
    }()
    
    lazy var leftBarButton: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(title: "용현 1, 4동", style: .plain, target: self, action: #selector(tapDropDown(_:)))
        leftBarButton.tintColor = .black
        return leftBarButton
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingImageScrollView()
        settingNavigationBar()
        collectionViewSetting()
    }
    
    
    //MARK: -위에 배너 구현
    private func settingImageScrollView(){
        view.addSubview(imageScrollView)
        imageScrollView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(210)
        }
        imageScrollView.contentSize.width = view.bounds.width * 10
        
        for i in 0..<10 {
            let xPos = self.view.bounds.width * CGFloat(i)
            let cute = UIView()
            cute.backgroundColor = i % 2 == 0 ? .blue : .red;
            cute.frame = CGRect(x: xPos, y: 0, width: self.view.bounds.width, height: 210)
            
            imageScrollView.addSubview(cute)
        }
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.delegate = self
        view.addSubview(imageScrollPageControll)
        imageScrollPageControll.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalTo(imageScrollView.snp.width)
            $0.height.equalTo(50)
            $0.bottom.equalTo(imageScrollView.snp.bottom).inset(5)
        }
    }
    
    
    //MARK: - setting navigation
    private func settingNavigationBar(){
        navigationItem.leftBarButtonItem = leftBarButton
        navigationController?.navigationBar.backgroundColor = .mainblue
        view.addSubview(statusBackView)
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        statusBackView.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(statusBarHeight)
        }
//        dropDown.dataSource = ["용현 1, 4동", "내 주변 3km"]
//        dropDown.anchorView = leftBarButton
//        dropDown.bottomOffset = CGPoint(x: 0, y: 40)
//        dropDown.cornerRadius = 15
//        dropDown.backgroundColor = .white
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            self.leftBarButton.title = item
//            self.dropDown.clearSelection()
//        }
    }
    @objc private func tapDropDown(_ sender: Any){
        //dropDown.show()
    }
    
    
    //MARK: - setting collectionview
    
    private func collectionViewSetting(){
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(imageScrollView.snp.bottom).offset(30)
        }
        collectionView.register(MainCollectionViewLongCell.self, forCellWithReuseIdentifier: LONG_CELL)
        collectionView.register(MainCollectionViewLargeCell.self, forCellWithReuseIdentifier: LARGE_CELL)
        collectionView.register(MainCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MainCollectionViewHeader")
        collectionView.register(MainCollectionViewSmallCell.self, forCellWithReuseIdentifier: SMALL_CELL)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout{ [weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil}
            switch sectionNumber % 3 {
            case 0:
                return self.zeroTypeSection()
            case 1:
                return self.oneTypeSection()
            case 2:
                return self.twoTypeSection()
            default:
                return nil
            }
        }
    }
    
    private func zeroTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(170), heightDimension: .absolute(180))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(1800), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 5, bottom: 5, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func oneTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(170), heightDimension: .absolute(240))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(1800), heightDimension: .absolute(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 5, bottom: 5, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func twoTypeSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(290), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(3000), heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 5, bottom: 5, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        
        // Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section % 3 {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SMALL_CELL, for: indexPath) as? MainCollectionViewSmallCell else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LARGE_CELL, for: indexPath) as? MainCollectionViewLargeCell else { return UICollectionViewCell() }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LONG_CELL, for: indexPath) as? MainCollectionViewLongCell else { return UICollectionViewCell() }
            return cell
        default:
            print("")
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MainCollectionViewHeader", for: indexPath) as? MainCollectionViewHeader else { return UICollectionReusableView()}
        headerview.delegate = self
        return headerview
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageScrollPageControll.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
}

extension MainViewController: tapMoreButton {
    func tapMoreButton(theme: Int) {
        let nextVC = MainStoreListViewController()
        nextVC.modalPresentationStyle = .fullScreen
        let backBarButtonItem = UIBarButtonItem(title: "요즘 떠오르는 우리 동네 식당", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .none
        self.navigationItem.backBarButtonItem = backBarButtonItem
        print("cute")
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}
