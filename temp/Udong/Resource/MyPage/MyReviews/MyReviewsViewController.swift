//
//  MyReviewsViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import Foundation
import UIKit
import SnapKit

class MyReviewsViewController: UIViewController {
    
    var reviewsTableView: UITableView = {
        let reviewsTableView = UITableView()
        
        return reviewsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "나의 리뷰"
        displaySetting()
    }
    
    private func displaySetting(){
        view.addSubview(reviewsTableView)
        reviewsTableView.register(UINib(nibName: "MyReivewsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyReivewsTableViewCell")
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyReivewsTableViewCell", for: indexPath) as? MyReivewsTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    
}
