//
//  ProfileViewController.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 11.04.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    var settings : [Settings]  = [Settings]()
    
    let imagePicker = UIImagePickerController()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let profileWithBorder: UIView = {
        let border = UIView()
        border.clipsToBounds = true
        border.layer.cornerRadius = 40
        border.layer.borderColor = UIColor.gray.cgColor
        border.layer.borderWidth = 1
        return border
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Mock.sampleUser.image))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 36
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var changeProfileImageButton: UIButton = {
        let cameraPlusImage = UIImage(named: "cameraPlus")?.withTintColor(UIColor.white, renderingMode: .automatic)
        let button = UIButton()
        button.setImage(cameraPlusImage, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return button
    }()
    
    let nameSurnameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Mock.sampleUser.name) \(Mock.sampleUser.surname)"
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Mock.sampleUser.email)"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.alpha = 0.5
        return label
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.cellId)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        self.navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .never
        
        
        createSettingsArray()
        
        scrollView.delegate = self
        imagePicker.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        configureScrollView()
        configureViews()
    }
    
    @objc func loadImageButtonTapped() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func configureScrollView(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.snp.width)
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
        }
        scrollView.showsVerticalScrollIndicator = false
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualTo(scrollView)
        }
    }
    
    private func configureViews() {
        profileWithBorder.addSubview(profileImage)
        profileImage.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(72)
        }
        
        contentView.addSubview(profileWithBorder)
        profileWithBorder.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(25)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.size.equalTo(80)
        }
        
        contentView.addSubview(changeProfileImageButton)
        changeProfileImageButton.snp.makeConstraints{
            $0.bottom.equalTo(profileWithBorder.snp.bottom)
            $0.trailing.equalTo(profileWithBorder.snp.trailing)
            $0.size.equalTo(28)
        }
        changeProfileImageButton.addTarget(self, action: #selector(self.loadImageButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(nameSurnameLabel)
        nameSurnameLabel.snp.makeConstraints{
            $0.top.equalTo(profileWithBorder.snp.bottom).offset(16)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        contentView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints{
            $0.top.equalTo(nameSurnameLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(emailLabel.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    func createSettingsArray() {
        settings.append(Settings(settingName: "Push уведомления", identity: .switchButton))
        settings.append(Settings(settingName: "Изменить пароль", identity: .changePassword))
        settings.append(Settings(settingName: "Изменить код быстрого доступа", identity: .rightItem))
        settings.append(Settings(settingName: "Вход с Face/Touch ID", identity: .switchButton))
        settings.append(Settings(settingName: "Изменить номер телефона", identity: .rightItem))
        settings.append(Settings(settingName: "Выход", identity: .exitButton))
    }
    
    func openChangePasswordVC(){
        let vc = UpdatePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate,
                                    UIScrollViewDelegate {
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellId, for: indexPath) as! SettingsTableViewCell
        let currentLastItem = settings[indexPath.row]
        cell.setting = currentLastItem
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = settings[indexPath.row].identity
        switch type {
        case .switchButton:
            return
        case .exitButton:
            print("Exit taped")
        case .changePassword:
            openChangePasswordVC()
        case .rightItem:
            return
        }
    }
    
}
