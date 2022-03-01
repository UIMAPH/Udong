
import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import SnapKit

class FirstViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let logoImage = UIImage(named: "Logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        
        return logoImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "우리 동네를 소개합니다"
        titleLabel.font = UIFont(name: "bold", size: 36)
        
        return titleLabel
    }()
    
    let subtitleView: UIView = {
        let subtitleLabel1 = UILabel()
        subtitleLabel1.text = "우리동네 사람들이 어디를 많이 가는지 궁금하지 않나요?"
        subtitleLabel1.font = UIFont(name: "", size: 24)
        
        let subtitleLabel2 = UILabel()
        subtitleLabel1.text = "지금 시작해보세요!"
        subtitleLabel1.font = UIFont(name: "", size: 24)
        
        let subtitleView = UIView()
        subtitleView.addSubview(subtitleLabel1)
        subtitleView.addSubview(subtitleLabel2)
        
        subtitleLabel1.snp.makeConstraints {
            $0.centerX.leading.trailing.top.equalToSuperview()
        }
        
        subtitleLabel2.snp.makeConstraints {
            $0.centerX.leading.trailing.equalToSuperview()
            $0.top.equalTo(subtitleLabel1.snp.bottom)
        }
        
        return subtitleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
    }
    
    func settingUI(){
        
    }
}
