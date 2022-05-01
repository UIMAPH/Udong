//
//  TabBarViewController.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/07.
//

import UIKit

// 할 일
// 1. 탭바 아이템 위치 조정
// 2. 카메라 버튼 커스텀

class TabBarViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTabBar()
    }
    
    // MARK: Tab Bar 요소 설정
    
    private func settingTabBar(){
        let homeTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        //homeTabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        let searchTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let cameraTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "camera.circle.fill"), tag: 2)
        let boardTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.bullet.rectangle.portrait"), tag: 3)
        let myPageTabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 4)
        
        
        let homeTab = UINavigationController(rootViewController: StoreDetailViewController())
        homeTab.tabBarItem = homeTabBarItem
        //homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: 300, left: 0, bottom: -300, right: 0)
        let searchTab = UINavigationController(rootViewController: TierInfoViewController())
        searchTab.tabBarItem = searchTabBarItem
        let cameraTab = UINavigationController(rootViewController: StoreDetailViewController())
        cameraTab.tabBarItem = cameraTabBarItem
        let boardTab = UINavigationController(rootViewController: StoreDetailViewController())
        boardTab.tabBarItem = boardTabBarItem
        let myPageTab = UINavigationController(rootViewController: StoreDetailViewController())
        myPageTab.tabBarItem = myPageTabBarItem
        
        let tabs = NSArray(objects: homeTab, searchTab, cameraTab, boardTab, myPageTab)
        self.setViewControllers(tabs as? [UIViewController], animated: true)
        
        // MARK: 탭바 색상 지정
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0xA8, green: 0xE2, blue: 0xFF)
        UITabBar.appearance().tintColor = .lightGray
        UITabBar.appearance().unselectedItemTintColor = .white
        
    }
    
}

// MARK: 탭바 높이 변경 - 실패
extension UITabBar{
    override open func sizeThatFits(_ size: CGSize) -> CGSize{
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 10
        return sizeThatFits
    }
}
