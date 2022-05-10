//
//  MyFavortieListPageViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import Foundation
import UIKit

class MyFavortieListPageViewController: UIPageViewController, UIPageViewControllerDataSource , UIPageViewControllerDelegate {
    var completeHandler : ((Int)->())?
    var appdelegate: pageChange? = nil
    
    let viewsList : [UIViewController] = {
        let vc1 = MyCustomStoreListTableViewController()
        let vc2 = MyWishStoreListTableViewController()
        
        return [vc1, vc2]
        
    }()
    
    
    var currentIndex : Int {
        guard let vc = viewControllers?.first else { return 0 }
        return viewsList.firstIndex(of: vc) ?? 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstvc = viewsList.first {
            self.setViewControllers([firstvc], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func setViewcontrollersFromIndex(index : Int){
        if index < 0 && index >= viewsList.count {return }
        if (index == 0){
            self.setViewControllers([viewsList[index]], direction: .reverse, animated: true, completion: nil)
        }else{
            self.setViewControllers([viewsList[index]], direction: .forward, animated: true, completion: nil)
        }
        completeHandler?(currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            
            appdelegate?.passIndex(idx: currentIndex)
            completeHandler?(currentIndex)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewsList.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = index - 1
        
        if previousIndex < 0 { return nil}
        
        return viewsList[previousIndex]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        guard let index = viewsList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = index + 1
        
        if nextIndex == viewsList.count { return nil}
        
        return viewsList[nextIndex]
        
        
    }
}

protocol pageChange{
    func passIndex(idx: Int)
}
