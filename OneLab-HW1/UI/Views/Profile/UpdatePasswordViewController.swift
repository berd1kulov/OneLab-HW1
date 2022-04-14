//
//  UpdatePasswordViewController.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 11.04.2022.
//

import UIKit
import SnapKit

class UpdatePasswordViewController: UIViewController {
    
    var composeViewBottomConstraint = -15
    
    let oldPassword: CustomTextField = {
        let password = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 30))
        password.placeholder = "Текущий пароль"
        password.isSecureTextEntry = true
        password.enablePasswordToggle()
        password.backgroundColor = .systemBackground
        return password
    }()
    
    let newPassword: CustomTextField = {
        let password = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 30))
        password.placeholder = "Новый пароль"
        password.isSecureTextEntry = true
        password.enablePasswordToggle()
        password.backgroundColor = .systemBackground
        return password
    }()
    
    let confirmNewPassword: CustomTextField = {
        let password = CustomTextField(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 30))
        password.placeholder = "Повторите новый пароль"
        password.isSecureTextEntry = true
        password.backgroundColor = .systemBackground
        return password
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        let attributeString = NSMutableAttributedString(
            string: "Забыли пароль ?",
            attributes: [
                .font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.secondaryLabel,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        button.setAttributedTitle(attributeString, for: .normal)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 20)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.prefersLargeTitles = false
        
        oldPassword.delegate = self
        newPassword.delegate = self
        confirmNewPassword.delegate = self
        
        configureTextFields()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func configureTextFields(){
        view.addSubview(oldPassword)
        oldPassword.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        view.addSubview(newPassword)
        newPassword.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(oldPassword.snp.bottom).offset(15)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        view.addSubview(confirmNewPassword)
        confirmNewPassword.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(newPassword.snp.bottom).offset(15)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(confirmNewPassword.snp.bottom).offset(32)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints{
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(view.snp.bottom).offset(composeViewBottomConstraint)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9)
            $0.height.equalTo(50)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.composeViewBottomConstraint = -15 - Int(keyboardSize.height)
        UIView.animate(withDuration: 0.3) { [weak self] in self?.updateViewConst()}
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.composeViewBottomConstraint = -15
        UIView.animate(withDuration: 0.3) { [weak self] in self?.updateViewConst()}
        self.view.layoutIfNeeded()
    }
    
    func updateViewConst() {
        saveButton.snp.updateConstraints{
            $0.bottom.equalTo(view.snp.bottom).offset(composeViewBottomConstraint)
        }
    }
}

extension UpdatePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "customBlue")?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
}
