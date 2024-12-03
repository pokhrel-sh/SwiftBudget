////
////  ViewController.swift
////
//// Signup page for parents and students
////
////  SwiftBudget
////
////  Created by Shishir Pokhrel on 12/2/24.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    var loginLabel: UILabel!
//    var nameField: UITextField!
//    var emailField: UITextField!
//    var parentEmailField: UITextField!
//    var passwordField: UITextField!
//    var submitButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        // MARK: Initializing the UI elements
//        setupLoginLabel()
//        setupNameField()
//        setupEmailField()
//        setupParentEmailField()
//        setupPasswordField()
//        setupSubmitButton()
//        
//        // MARK: Initializing the constraints
//        initConstraints()
//    }
//    
//    func setupLoginLabel() {
//        loginLabel = UILabel()
//        loginLabel.text = "Sign Up"
//        loginLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        loginLabel.textAlignment = .center
//        loginLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(loginLabel)
//    }
//
//    func setupParentEmailField() {
//        parentEmailField = UITextField()
//        parentEmailField.placeholder = "Parent Email"
//        parentEmailField.borderStyle = .roundedRect
//        parentEmailField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(parentEmailField)
//    }
//    
//    func setupNameField() {
//        nameField = UITextField()
//        nameField.placeholder = "Name"
//        nameField.borderStyle = .roundedRect
//        nameField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(nameField)
//    }
//    
//    func setupEmailField() {
//        emailField = UITextField()
//        emailField.placeholder = "Email"
//        emailField.borderStyle = .roundedRect
//        emailField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(emailField)
//    }
//    
//    func setupPasswordField() {
//        passwordField = UITextField()
//        passwordField.placeholder = "Password"
//        passwordField.borderStyle = .roundedRect
//        passwordField.isSecureTextEntry = true
//        passwordField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(passwordField)
//    }
//    
//    func setupSubmitButton() {
//        submitButton = UIButton(type: .system)
//        submitButton.setTitle("Sign Up", for: .normal)
//        submitButton.setTitleColor(.white, for: .normal)
//        submitButton.backgroundColor = .systemBlue
//        submitButton.layer.cornerRadius = 10
//        submitButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(submitButton)
//    }
//    
//    func initConstraints() {
//        let fieldSpacing: CGFloat = 20
//        let sizeableGap: CGFloat = 40
//        
//        NSLayoutConstraint.activate([
//            // Login Label Constraints
//            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
//            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            // Name Field Constraints
//            nameField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: sizeableGap),
//            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
//            
//            // Email Field Constraints
//            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: fieldSpacing),
//            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
//            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
//            
//            // Parent Email Field Constraints
//            parentEmailField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: fieldSpacing),
//            parentEmailField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
//            parentEmailField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
//            
//            // Password Field Constraints
//            passwordField.topAnchor.constraint(equalTo: parentEmailField.bottomAnchor, constant: fieldSpacing),
//            passwordField.leadingAnchor.constraint(equalTo: parentEmailField.leadingAnchor),
//            passwordField.trailingAnchor.constraint(equalTo: parentEmailField.trailingAnchor),
//            
//            // Submit Button Constraints
//            submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: sizeableGap),
//            submitButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
//            submitButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
//            submitButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//}
