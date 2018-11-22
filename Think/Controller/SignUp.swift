//
//  SignUp.swift
//  Think
//
//  Created by Jonathan on 11/19/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit

class SignUp: UIViewController {
    
    let topContainer:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.colors.primary
        container.isUserInteractionEnabled = true
        return container
    }()
    
    let addImageBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Avatar").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let signUpContainer:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nameTextField:CustomTextField = {
        let field = CustomTextField(type: .name)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return field
    }()
    
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
    
    static let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupTopContainer()
        setupSignUpSection()
        setDelegates()
    }
    
    fileprivate func setDelegates() {
        nameTextField.textField.delegate = self
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
    }
    
    fileprivate func setupButtons() {
        passwordTextField.tryImage.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc fileprivate func signUp() {
        guard let safeName = nameTextField.textField.text else { return }
        guard let safeEmail = emailTextField.textField.text else { return }
        guard let safePassword = passwordTextField.textField.text else { return }
        guard let safeImage = addImageBtn.imageView?.image else { return }
        SignUp.dispatchGroup.enter()
        FirebaseManager.shared.login(name: safeName, email: safeEmail, password: safePassword, image: safeImage)
        SignUp.dispatchGroup.notify(queue: .main) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    fileprivate func setupTopContainer() {
        view.backgroundColor = .white
        view.addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            topContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            topContainer.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        
        topContainer.addSubview(addImageBtn)
        NSLayoutConstraint.activate([
            addImageBtn.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor, constant: 0),
            addImageBtn.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor, constant: 30)
            ])
    }

    fileprivate func setupSignUpSection() {
        view.addSubview(signUpContainer)
        NSLayoutConstraint.activate([
            signUpContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            signUpContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        let stackView:UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.backgroundColor = .red
            sv.axis = .vertical
            sv.spacing = 10
            return sv
        }()
        
        signUpContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: signUpContainer.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: signUpContainer.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: signUpContainer.topAnchor, constant: 40)
            ])
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        let signUpBtn:UIButton = {
            let btn = UIButton(type: .system)
            btn.setTitle("Sign Up", for: .normal)
            btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = UIColor.colors.primary
            btn.layer.cornerRadius = 25
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
            NSLayoutConstraint.activate([
                btn.heightAnchor.constraint(equalToConstant: 50),
                btn.widthAnchor.constraint(equalToConstant: 183)])
            return btn
        }()
        
        signUpContainer.addSubview(signUpBtn)
        NSLayoutConstraint.activate([
            signUpBtn.centerXAnchor.constraint(equalTo: signUpContainer.centerXAnchor),
            signUpBtn.bottomAnchor.constraint(equalTo: signUpContainer.bottomAnchor, constant: -30)
            ])
    }
}

extension SignUp:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.textField == textField {
            emailTextField.textField.becomeFirstResponder()
        } else if emailTextField.textField == textField {
            passwordTextField.textField.becomeFirstResponder()
        } else {
            // Sign In....
        }
        return true
    }
}
