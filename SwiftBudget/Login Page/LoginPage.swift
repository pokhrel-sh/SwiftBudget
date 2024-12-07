//
//  ViewController.swift
//
// Login page for everyone
//
//  SwiftBudget
//
//  Created by Shishir Pokhrel on 12/2/24.
//

import UIKit

class LoginPage: UIView {

    var loginLabel: UILabel!
    var nameField: UITextField!
    var emailField: UITextField!
    var parentEmailField: UITextField!
    var passwordField: UITextField!
    var submitButton: UIButton!
    var signupButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // MARK: Initializing the UI elements
        setupLoginLabel()
        setupEmailField()
        setupPasswordField()
        setupSubmitButton()
        setupSignupButton()
        
        // MARK: Initializing the constraints
        initConstraints()
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 24)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
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
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Login", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Register", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = .systemBlue
        signupButton.layer.cornerRadius = 10
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signupButton)
    }
    
    func initConstraints() {
        let fieldSpacing: CGFloat = 40
        let sizeableGap: CGFloat = 80
        
        NSLayoutConstraint.activate([
            // Login Label Constraints
            loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Email Field Constraints
            emailField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: fieldSpacing),
            emailField.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 200),
            // Password Field Constraints
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: fieldSpacing),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            
            // Submit Button Constraints
            submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: sizeableGap),
            submitButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            
            signupButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: sizeableGap),
            signupButton.leadingAnchor.constraint(equalTo: submitButton.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
