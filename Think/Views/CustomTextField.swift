//
//  CustomTextField.swift
//  Think
//
//  Created by Jonathan on 11/19/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class CustomTextField: UIView {
    
    enum type {
        case email
        case password
        case name
    }
    
    var typeOfObject:type = .email
    
    let textField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        field.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.colors.neutral4])
        field.textColor = UIColor.colors.neutral4
        field.placeholder = "E-Mail"
        return field
    }()
    
    let tryImage:UIButton = {
        let image = UIButton(type: .system)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setImage(#imageLiteral(resourceName: "try").withRenderingMode(.alwaysOriginal), for: .normal)
        image.alpha = 0
        return image
    }()
    
    var image:UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = #imageLiteral(resourceName: "LockNotActive")
        return icon
    }()
    
    let line:UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red:0.94, green:0.95, blue:0.97, alpha:1.00)
        return line
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type:type) {
        self.init(frame: .zero)
        
        if type == .email {
            image.image = #imageLiteral(resourceName: "EmailNotActive")
            typeOfObject = type
            startUI(icon: image)
            textField.placeholder = "E-Mail"
            textField.returnKeyType = .next
        } else if type == .password{
            image.image = #imageLiteral(resourceName: "LockNotActive")
            typeOfObject = type
            startUI(icon: image)
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.returnKeyType = .continue
        } else if type == .name {
            image.image = #imageLiteral(resourceName: "name")
            typeOfObject = type
            startUI(icon: image)
            textField.placeholder = "Name"
            textField.returnKeyType = .next
        }
        
        startUI(icon: image)
        
    }
    
    fileprivate func startUI(icon:UIImageView) {
        self.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            textField.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        self.addSubview(tryImage)
        NSLayoutConstraint.activate([
            tryImage.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            tryImage.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0),
            tryImage.widthAnchor.constraint(equalToConstant: 60),
            tryImage.heightAnchor.constraint(equalTo: self.heightAnchor)
            ])
        
        self.addSubview(line)
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: icon.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 21)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2) {
            self.tryImage.alpha = 0
            self.layoutIfNeeded()
        }
    }
    func show() {
        UIView.animate(withDuration: 0.2) {
            self.tryImage.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
}

