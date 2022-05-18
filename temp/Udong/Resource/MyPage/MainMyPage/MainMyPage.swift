
import UIKit
import SnapKit
import Kingfisher

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
    
    
    var myProfileTableView: UITableView = {
        let recentVisitStoreTableView = UITableView()
        
        return recentVisitStoreTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNetwork()
        settingNavigation()
        settingAutoLayout()
    }
    
    private func settingNetwork(){
        MainMyPageService.shared.loadProfile(completion: { result in
            switch result {
            case .success(let thisdata):
                if let responseValue = thisdata as? NetkResponse<MainMyPageModel>,
                   let profile = responseValue.data {
                    DispatchQueue.main.async {
                        self.profileName.text = profile.username
                        self.profileAddress.text = profile.regionName ?? "용현동 79-23 샬롬원룸 303호"
                        self.profileImageView.kf.setImage(with: URL(string: profile.profileImageUrl ?? ""))
                        
                    }
                }
            case .requestErr(_):
                print("requestErr")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
    
    private func settingAutoLayout(){
        let g = UITapGestureRecognizer(target: self, action: #selector(taptaptap(_:)))
        profileImageView.addGestureRecognizer(g)
        view.addSubview(profileName)
        view.addSubview(profileImageView)
        view.addSubview(profileAddress)
        view.addSubview(myProfileTableView)
        
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
        
        myProfileTableView.largeContentTitle = "최근 방문한 가게"
        myProfileTableView.dataSource = self
        myProfileTableView.delegate = self
        myProfileTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
        myProfileTableView.register(UINib(nibName: "SixButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "SixButtonTableViewCell")
        myProfileTableView.register(UINib(nibName: "RecentVisitStoreTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentVisitStoreTableViewCell")
        myProfileTableView.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.bottom).offset(4)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UITableViewHeaderFooterView")
            let titleLabel = UILabel()
            titleLabel.text = "최근 방문한 가게"
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            header?.addSubview(titleLabel)
            titleLabel.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            header?.backgroundColor = .white
            
            return header
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SixButtonTableViewCell", for: indexPath) as? SixButtonTableViewCell else { return UITableViewCell() }
            cell.appDelegate = self
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentVisitStoreTableViewCell", for: indexPath) as? RecentVisitStoreTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 225
        }
        return 160
    }
}

extension MainMyPageViewController: tapSixButton {
    func tapButton(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
