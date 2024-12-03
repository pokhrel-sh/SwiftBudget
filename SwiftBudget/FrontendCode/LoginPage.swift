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

class ViewController: UIViewController {

    var loginLabel: UILabel!
    var nameField: UITextField!
    var emailField: UITextField!
    var parentEmailField: UITextField!
    var passwordField: UITextField!
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: Initializing the UI elements
        setupLoginLabel()
        setupEmailField()
        setupPasswordField()
        setupSubmitButton()
        
        // MARK: Initializing the constraints
        initConstraints()
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 24)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
    }

    func setupEmailField() {
        emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)
    }
    
    func setupPasswordField() {
        passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)
    }
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Login", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
    }
    
    func initConstraints() {
        let fieldSpacing: CGFloat = 40
        let sizeableGap: CGFloat = 80
        
        NSLayoutConstraint.activate([
            // Login Label Constraints
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Email Field Constraints
            emailField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: fieldSpacing),
            emailField.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
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
