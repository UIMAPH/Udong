//
//  StoreInfoCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/13.
//

import Foundation

class StoreInfoCollectionViewCell: UICollectionViewCell{
    
    var iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.displaySetting()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.displaySetting()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.displaySetting()
    }
        
    private func displaySetting(){
        iconImageView.image = UIImage()
        iconImageView.tintColor = .black
       
        label.text = ""
        label.font = label.font.withSize(15)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        
        iconImageView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(15)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
    }
    
    // MARK: 영업시간 더보기 버튼 설정
    
    func detailBtnSetting(){
        
        let detailBtn: UIButton = {
            // TODO: 버튼 탭 면적 늘리기
            let detailBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let btnImage = UIImage(systemName: "chevron.down")
            detailBtn.setImage(btnImage, for: .normal)
            detailBtn.addTarget(self, action: #selector(detailBtnDidTap(_:)), for: .touchUpInside)
            //detailBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            detailBtn.tintColor = .black
            return detailBtn
        }()
        
        contentView.addSubview(detailBtn)
        detailBtn.snp.makeConstraints{
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(label.snp.trailing).offset(10)
        }
        
    }
    
    // TODO: 버튼 눌렀을 때 영업시간 뷰 추가
    @objc private func detailBtnDidTap(_ sender: Any){
        print("detail button tap")
        //StoreInfoCell().updateCollectionView()
    }
}

//class OfficeHourCollectionViewCell: UICollectionViewCell{
//
//    var officeHourLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.displaySetting()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func displaySetting(){
//        officeHourLabel.text = ""
//        officeHourLabel.font = officeHourLabel.font.withSize(15)
//
//        contentView.addSubview(officeHourLabel)
//        officeHourLabel.snp.makeConstraints{
//            $0.top.leading.equalToSuperview().offset(15)
//        }
//    }
//
//}
