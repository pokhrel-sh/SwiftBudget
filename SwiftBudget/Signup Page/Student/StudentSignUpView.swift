//
//  StudentSignUpView.swift
//  SwiftBudget
//
//  Created by Akshay Tolani on 12/7/24.
//

import UIKit

class StudentSignUpView: UIView {
    
    
    var nameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupNameField()
        setupEmailField()
        setupPasswordField()
        setupRegisterButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNameField() {
        nameField = UITextField()
        nameField.placeholder = "Name"
        nameField.borderStyle = .roundedRect
        nameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameField)
    }
    
    func setupEmailField() {
        emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailField)
    }
    
    func setupPasswordField() {
        passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordField)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Register as Student", for: .normal)
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            nameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            nameField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}



