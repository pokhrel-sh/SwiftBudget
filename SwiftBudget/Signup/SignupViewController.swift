//
//  SignupViewController.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit

class SignupViewController: UIViewController {

    let signupScreen = SignupPage()
        
    override func loadView() {
        view = signupScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        
        signupScreen.submitButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)

    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        registerNewAccount()
    }
}
