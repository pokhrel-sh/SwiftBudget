//
//  ViewController.swift
//
// Signup page for parents and students
//
//  SwiftBudget
//
//  Created by Shishir Pokhrel on 12/2/24.
//

import UIKit

class SignupPage: UIView {

    var loginLabel: UILabel!
    var nameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var submitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        // MARK: Initializing the UI elements
        setupLoginLabel()
        setupNameField()
        setupEmailField()
        setupPasswordField()
        setupSubmitButton()
        
        // MARK: Initializing the constraints
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Sign Up"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 24)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
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
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Sign Up", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
    }
    
    func initConstraints() {
        let fieldSpacing: CGFloat = 20
        let sizeableGap: CGFloat = 40
        
        NSLayoutConstraint.activate([
            // Login Label Constraints
            loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Name Field Constraints
            nameField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: sizeableGap),
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            nameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            // Email Field Constraints
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: fieldSpacing),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            // Password Field Constraints
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: fieldSpacing),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            // Submit Button Constraints
            submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: sizeableGap),
            submitButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
