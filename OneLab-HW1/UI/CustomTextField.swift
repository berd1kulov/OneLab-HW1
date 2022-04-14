//
//  CustomTextField.swift
//  OneLab-HW1
//
//  Created by Bakdaulet Berdikul on 11.04.2022.
//

import UIKit

class CustomTextField: UITextField {

    let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets){
        self.insets = insets
        super.init(frame: .zero)
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
}

import Foundation
import UIKit

extension UITextField {
    
    func enablePasswordToggle(){
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "u_eye")?.withTintColor(.label, renderingMode: .automatic), for: .normal)
        button.setImage(UIImage(named: "u_eye-slash")?.withTintColor(.label, renderingMode: .automatic), for: .selected)
        button.tintColor = .label
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 13)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
