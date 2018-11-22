//
//  SignIn.swift
//  Think
//
//  Created by Jonathan on 11/18/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
    let topContainer:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.colors.primary
        container.isUserInteractionEnabled = true
        return container
    }()
    
    let signInContainer:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = true
        return container
    }()
    
    @objc fileprivate func stopEditing(sender:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    let emailTextField:CustomTextField = {
        let field = CustomTextField(type: .email)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return field
    }()
    
    let passwordTextField:CustomTextField = {
        let field = CustomTextField(type: .password)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return field
    }()
    
    let forgotBtn:UIButton = {
        let text = UIButton(type: .system)
        text.setTitle("FORGOT PASSWORD", for: .normal)
        text.setTitleColor(UIColor.colors.neutral4, for: .normal)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.heightAnchor.constraint(equalToConstant: 60).isActive = true
        text.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 11)
        return text
    }()
    
    fileprivate var shifted = false
    
    
    fileprivate func setDelegates() {
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTopSection()
        setupLoginSection()
        setDelegates()
        signInContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEditing(sender:))))
        topContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stopEditing(sender:))))
    }
    
    @objc func btnClick() {
        
    }
    
    fileprivate func setupNav() {
        let signUp = UIButton(type: .system)
        signUp.setTitle("Sign Up  ", for: .normal)
        signUp.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        signUp.tintColor = .white
        signUp.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        let signUpBtn = UIBarButtonItem(customView: signUp)
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        spacer.width = 20
        self.navigationItem.rightBarButtonItems = [signUpBtn]
        let backItem = UIBarButtonItem(title: "  Sign In", style: .done, target: self, action: nil)
        backItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
        navigationItem.backBarButtonItem = backItem
    }
    
    @objc fileprivate func handleSignUp() {
        let signUp = SignUp()
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    fileprivate func setupTopSection() {
        view.backgroundColor = .white
        view.addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            topContainer.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        
        let logoImage:UIImageView = {
            let image = UIImageView(image: #imageLiteral(resourceName: "Logo"))
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
            return image
        }()
        topContainer.addSubview(logoImage)
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor, constant: 0),
            logoImage.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: 30),
            logoImage.heightAnchor.constraint(equalToConstant: 80),
            logoImage.widthAnchor.constraint(equalToConstant: 80)
            ])
    }
    
    fileprivate func setupLoginSection() {
        
        view.addSubview(signInContainer)
        NSLayoutConstraint.activate([
            signInContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            signInContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            signInContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        let stackView:UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.backgroundColor = .red
            sv.axis = .vertical
            sv.spacing = 10
            return sv
        }()
        
        signInContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: signInContainer.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: signInContainer.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: signInContainer.topAnchor, constant: 40)
            ])
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(forgotBtn)
        
        let signInBtn:UIButton = {
            let btn = UIButton(type: .system)
            btn.setTitle("Sign In", for: .normal)
            btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = UIColor.colors.primary
            btn.layer.cornerRadius = 25
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: 50),
                btn.widthAnchor.constraint(equalToConstant: 183)])
            return btn
        }()
        
        signInContainer.addSubview(signInBtn)
        NSLayoutConstraint.activate([
            signInBtn.centerXAnchor.constraint(equalTo: signInContainer.centerXAnchor),
            signInBtn.bottomAnchor.constraint(equalTo: signInContainer.bottomAnchor, constant: -30)
            ])
        
    }
    
}


extension SignIn:UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if passwordTextField.textField == textField && emailTextField.textField.text != "" {
            let count = (passwordTextField.textField.text?.count)! + 1
            if count >= 7 {
                passwordTextField.show()
            } else {
                passwordTextField.hide()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.textField == textField {
            passwordTextField.textField.becomeFirstResponder()
        }
        return true
    }
    
    
}

