//
//  MyCustomStoreListTableViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/10.
//

import Foundation
import UIKit

class MyCustomStoreListTableViewController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetting()
        
    }
    private func tableViewSetting(){
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "MyCustomStoreTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCustomStoreTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomStoreTableViewCell", for: indexPath) as? MyCustomStoreTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    private func displaySetting(){
        
    }
}
