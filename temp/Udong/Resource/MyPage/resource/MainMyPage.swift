
import UIKit
import SnapKit

class MainMyPageViewController: UIViewController {
    
    var profileImageView: UIImageView = {
        let image = UIImage(named: "sample")
        let profileImageView = UIImageView(image: image)
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 20
        
        return profileImageView
    }()
    
    var profileName: UILabel = {
        let profileName = UILabel()
        profileName.text = "김동완"
        profileName.font = UIFont(name: "system.bold", size: 18)
        
        return profileName
    }()
    
    var profileAddress: UILabel = {
        let profileAddress = UILabel()
        profileAddress.text = "인천광역시 용현동"
        profileAddress.font = UIFont(name: "system", size: 14)
        
        return profileAddress
    }()
    
    var profileButtons = MainMyPageButtonsView()
    
    var recentVisitStoreTableView: UITableView = {
        let recentVisitStoreTableView = UITableView()
        
        return recentVisitStoreTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigation()
        settingAutoLayout()
    }
    
    private func settingAutoLayout(){
        let g = UITapGestureRecognizer(target: self, action: #selector(taptaptap(_:)))
        profileImageView.addGestureRecognizer(g)
        view.addSubview(profileName)
        view.addSubview(profileImageView)
        view.addSubview(profileAddress)
        view.addSubview(profileButtons)
        view.addSubview(recentVisitStoreTableView)
        
        profileImageView.snp.makeConstraints{
            $0.width.height.equalTo(110)
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    
        profileName.snp.makeConstraints{
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        profileAddress.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.centerY).offset(10)
            $0.leading.equalTo(profileName.snp.leading)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        profileButtons.delegate = self
        profileButtons.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(270)
        }
        
        recentVisitStoreTableView.largeContentTitle = "최근 방문한 가게"
        recentVisitStoreTableView.dataSource = self
        recentVisitStoreTableView.delegate = self
        recentVisitStoreTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
        recentVisitStoreTableView.register(UINib(nibName: "RecentVisitStoreTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentVisitStoreTableViewCell")
        recentVisitStoreTableView.snp.makeConstraints{
            $0.top.equalTo(profileButtons.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func taptaptap(_ sender: UIGestureRecognizer){
        print("ttt")
    }
    
    private func settingNavigation(){
        title = "마이페이지"
    }
    
}

extension MainMyPageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "최근 방문한 가게"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitStoreTableViewCell", for: indexPath) as? RecentVisitStoreTableViewCell else { return UITableViewCell() }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}

extension MainMyPageViewController: tapImageView {
    func tapImageIndex(index: Int) {
        print(index)
    }
}

