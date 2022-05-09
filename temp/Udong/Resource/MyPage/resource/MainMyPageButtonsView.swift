
import UIKit

class MainMyPageButtonsView: UIView {
    
    
    var delegate: tapImageView? = nil
    
    @IBOutlet var profileName: tapTypeImageView!
    @IBOutlet var profileStore: tapTypeImageView!
    @IBOutlet var profilebadge: tapTypeImageView!
    @IBOutlet var profileArea: tapTypeImageView!
    @IBOutlet var profileReview: tapTypeImageView!
    @IBOutlet var profileSetting: tapTypeImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        xibView.frame = self.bounds
        self.addSubview(xibView)
        
        let arrImgView = [profileName, profileStore, profilebadge, profileArea, profileReview, profileSetting]
        for i in 0 ... 5 {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapImageView(sender:)))
            arrImgView[i]?.addGestureRecognizer(gesture)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func tapImageView(sender: tapTypeImageView){
        print("sss")
        delegate?.tapImageIndex(index: 1)
    }
}

protocol tapImageView {
    func tapImageIndex(index: Int)
}

class tapTypeImageView: UIImageView {
    var tapType: Int?
}
