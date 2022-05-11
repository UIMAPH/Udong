//
//  QnAViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/11.
//

import Foundation
import UIKit
import SnapKit

class QnAViewController: UIViewController{
    
    
    var toggleList: [Bool] = {
        var toggleList = [Bool]()
        for i in 0..<10 {
            toggleList.append(false)
        }
        return toggleList
    }()
    
    var QnATableView: UITableView = {
        let QnATableview = UITableView()
        QnATableview.backgroundColor = .mainblue
        return QnATableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
        title = "QnA"
    }
    
    private func displaySetting(){
        view.backgroundColor = .mainblue
        view.addSubview(QnATableView)
        QnATableView.register(UINib(nibName: "QnASectionTableViewCell", bundle: nil), forCellReuseIdentifier: "QnASectionTableViewCell")
        QnATableView.register(UINib(nibName: "QnARowTableViewCell", bundle: nil), forCellReuseIdentifier: "QnARowTableViewCell")
        QnATableView.delegate = self
        QnATableView.dataSource = self
        QnATableView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension QnAViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toggleList[section] {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QnASectionTableViewCell", for: indexPath) as! QnASectionTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QnARowTableViewCell", for: indexPath) as! QnARowTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if toggleList[indexPath.section] {
                print("close")
                print(indexPath.section)
                toggleList[indexPath.section] = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .fade)
            } else {
                print("open")
                print(indexPath.section)
                toggleList[indexPath.section] = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .fade)
            }
        }
    }
    
}
