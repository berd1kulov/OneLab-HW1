//
//  ProfileImageCell.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 14.04.2022.
//

import UIKit

class ProfileImageCell: UITableViewCell {

    static let cellId = "cellId"
    var profileImageView : UIView? {
        didSet {
            profileImage = profileImageView ?? UIView()
            profileImage.snp.makeConstraints {
                $0.top.equalTo(10)
                $0.centerX.equalToSuperview()
                $0.size.equalTo(80)
                $0.bottom.equalTo(-15)
            }
            
            changeProfileImageButton.snp.makeConstraints{
                $0.bottom.equalTo(profileImage.snp.bottom)
                $0.trailing.equalTo(profileImage.snp.trailing)
                $0.size.equalTo(28)
            }
        }
    }
    
    private var profileImage = UIView()
    
    lazy var changeProfileImageButton: UIButton = {
        let cameraPlusImage = UIImage(named: "cameraPlus")?.withTintColor(UIColor.white, renderingMode: .automatic)
        let button = UIButton()
        button.setImage(cameraPlusImage, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(changeProfileImageButton)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
