//
//  StoreInfoCollectionViewCell.swift
//  Udong
//
//  Created by  sangyeon on 2022/03/13.
//

import Foundation

class StoreInfoCell: UICollectionViewCell{
    
    let iconImages = [UIImage(systemName: "mappin.and.ellipse"), UIImage(systemName: "phone.fill"), UIImage(systemName: "clock")]
    var labels = ["주소", "전화번호", "영업시간"]  /// 가게 주소, 전화번호, 영업시간 저장
    let officeHours = ["월요일", "월요일", "월요일", "월요일", "월요일", "월요일", "월요일"]
    var detailBtnState: Bool = false
    
    lazy var collectionView: UICollectionView = {
        let f1 = UICollectionViewFlowLayout()
        f1.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
        return cv
    }()
//
//    lazy var officeHourcollectionView: UICollectionView = {
//        let f1 = UICollectionViewFlowLayout()
//        f1.scrollDirection = .vertical
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: f1)
//        return cv
//    }()
//
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionViewSetting()
    }
}

extension StoreInfoCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private func collectionViewSetting(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StoreInfoCollectionViewCell.self, forCellWithReuseIdentifier: "storeInfoCollectionViewCell")
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(!detailBtnState){
//            return labels.count
//        }
//        else{
//            return 3 + officeHours.count
//        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storeInfoCollectionViewCell", for: indexPath) as! StoreInfoCollectionViewCell
        
        if(indexPath.row == 2){
            cell.detailBtnSetting()
        }
        
        cell.iconImageView.image = iconImages[indexPath.row]
        cell.label.text = labels[indexPath.row]
        
//        if(!detailBtnState){
//            cell.iconImageView.image = iconImages[indexPath.row]
//            cell.label.text = labels[indexPath.row]
//        } else{
//            print("state is true")
//            if(indexPath.row < 3){
//                cell.label.text = labels[indexPath.row]
//            } else{
//                cell.label.text = officeHours[indexPath.row - 3]
//            }
//        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

//extension StoreInfoCell{
//    public func updateCollectionView(){
//        labels += officeHours
//        if(detailBtnState == true){
//            print("detail is true")
//            detailBtnState = false
//            collectionView.reloadData()
//        } else{
//            print("state if false")
//            detailBtnState = true
//            collectionView.reloadData()
//            print(detailBtnState)
//        }
//    }
//}

//extension StoreInfoCell{
//
//    func officeHourCollectionViewSetting(){
//
//        print("func call")
//
//        //StoreDetailViewController().
//
//        officeHourcollectionView.delegate = self
//        officeHourcollectionView.dataSource = self
//        officeHourcollectionView.register(OfficeHourCollectionViewCell.self, forCellWithReuseIdentifier: "officeHourCollectionViewCell")
//
//        contentView.addSubview(officeHourcollectionView)
//        officeHourcollectionView.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(5)
//            $0.leading.equalToSuperview()
//        }
//
//        StoreDetailViewController().collectionViewSetting()
//    }
//
//}

class StoreInfoCollectionViewCell: UICollectionViewCell{
    
    var iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.displaySetting()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
