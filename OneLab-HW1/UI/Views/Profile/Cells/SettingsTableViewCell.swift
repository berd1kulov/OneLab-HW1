//
//  SettingsTableViewCell.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 13.04.2022.
//

import UIKit
import SnapKit

class SettingsTableViewCell : UITableViewCell {

    static let cellId = "cellId"
    var setting : Settings? {
        didSet {
            settingNameLabel.text = setting?.settingName
            
            switch setting?.identity{
                
            case .rightItem, .changePassword:
                contentView.addSubview(settingsView)
                settingsView.snp.makeConstraints{
                    $0.centerY.equalTo(contentView.snp.centerY)
                    $0.trailing.equalTo(contentView.snp.trailing)
                    $0.size.equalTo(contentView.snp.height)
                }
            case .switchButton:
                contentView.addSubview(switchButton)
                switchButton.onTintColor = UIColor.blue
                switchButton.snp.makeConstraints{
                    $0.centerY.equalTo(contentView.snp.centerY)
                    $0.trailing.equalTo(contentView.snp.trailing).inset(15)
                }
            case .exitButton:
                settingNameLabel.textColor = .red
            case .none:
                break
            }
        }
    }
    
    private var footerLineView: UIView = {
        let footerLine = UIView()
        footerLine.backgroundColor = UIColor.lightGray
        return footerLine
    }()
    
    
    private let settingNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont(name: "Montserrat-Regular", size: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let switchButton = UISwitch()
    
    private let settingsView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-right")!.withTintColor(UIColor.secondaryLabel, renderingMode: .automatic), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(settingNameLabel)
        addSubview(footerLineView)
        settingNameLabel.snp.makeConstraints{
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(contentView.snp.leading).offset(15)
        }
        
        footerLineView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.left.equalTo(15)
            $0.right.equalTo(-15)
            $0.bottom.equalToSuperview()
        }
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
