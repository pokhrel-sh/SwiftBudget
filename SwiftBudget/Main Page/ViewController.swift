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
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    let landingPage = LandingPage()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = landingPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landingPage.dependantButton.addTarget(self, action: #selector(navigateToDependentSignup), for: .touchUpInside)
        landingPage.parentButton.addTarget(self, action: #selector(navigateToParentSignup), for: .touchUpInside)
        landingPage.studentButton.addTarget(self, action: #selector(navigateToStudentSignup), for: .touchUpInside)
     
        landingPage.loginButton.addTarget(self, action: #selector(navigatetoLogin), for: .touchUpInside)
    }
    
    @objc private func navigateToStudentSignup() {
        let studentSignupVC = StudentSignupViewController()
        navigationController?.pushViewController(studentSignupVC, animated: true)
    }
    
    @objc private func navigateToDependentSignup() {
        print("Navigating to Kid Register View Controller")
        let dependentSignupVC = KidRegisterViewController()
        navigationController?.pushViewController(dependentSignupVC, animated: true)
    }
    
    @objc private func navigateToParentSignup() {
        let parentSignupVC = ParentRegisterViewController()
        navigationController?.pushViewController(parentSignupVC, animated: true)
    }
    
    @objc private func navigatetoLogin() {
        do{
            try Auth.auth().signOut()
            print("User Logged Out")
        }catch{
            print("Error occured!")
        }
        
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
