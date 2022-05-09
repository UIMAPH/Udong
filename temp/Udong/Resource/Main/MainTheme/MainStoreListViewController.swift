//
//  MainStoreListViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/03/06.
//

import Foundation
import UIKit
import SnapKit

class MainStoreListViewController: UIViewController {
    
    lazy var storeMapView: MTMapView = {
        let storeMapView = MTMapView()
        storeMapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        return storeMapView
    }()
    
    lazy var storeScrollView: UIScrollView = {
        let storeScrollView = UIScrollView()
        storeScrollView.backgroundColor = .clear
        storeScrollView.delegate = self
        
        return storeScrollView
    }()
    
    
    lazy var storeTableView: UITableView = {
        let storeTablewView = UITableView()
        storeTablewView.backgroundColor = .red
        
        return storeTablewView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationBar()
        settingScrollView()
        settingMapView()
        settingTableView()
    }
    private func settingNavigationBar(){
        let backBarButtonItem = UIBarButtonItem(title: "요즘 떠오르는 우리 동네 식당", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    
    private func settingScrollView(){
        view.addSubview(storeScrollView)
        storeScrollView.contentSize = CGSize(width: view.bounds.width, height: 2100 + 600)
        storeScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        storeScrollView.showsVerticalScrollIndicator = false
        storeScrollView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        storeScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
    }
    
    private func settingMapView(){
        storeScrollView.addSubview(storeMapView)
        storeMapView.translatesAutoresizingMaskIntoConstraints = false
        storeMapView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(230)
            
        }
    }
    
    private func settingTableView(){
        storeScrollView.addSubview(storeTableView)
        storeTableView.register(MainStoreListTableViewCell.self, forCellReuseIdentifier: "MainStoreListTableViewCell")
        storeTableView.contentSize = CGSize(width:storeScrollView.frame.width, height: 2100)
        storeTableView.showsVerticalScrollIndicator = false
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.translatesAutoresizingMaskIntoConstraints = false
        storeTableView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(storeMapView.snp.bottom)
            $0.centerX.equalToSuperview()
            //$0.leading.equalToSuperview()
            $0.height.equalTo(2100)
        }
        //print(storeTableView.he)
    }
}

extension MainStoreListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainStoreListTableViewCell", for: indexPath) as? MainStoreListTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    
}

extension MainStoreListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y <= 0){
            var addHeight = -scrollView.contentOffset.y / 4
            if (storeMapView.frame.height <= 530){
                storeMapView.snp.updateConstraints{
                    $0.height.equalTo(storeMapView.frame.height + addHeight)
                }
            }
            print(scrollView.contentOffset.y)
            //scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        } else {
            var addHeight = scrollView.contentOffset.y / 4
            if (storeMapView.frame.height >= 230){
                storeMapView.snp.updateConstraints{
                    $0.height.equalTo(storeMapView.frame.height - addHeight)
                }
            }
            print(scrollView.contentOffset.y)
        }
    }
}
