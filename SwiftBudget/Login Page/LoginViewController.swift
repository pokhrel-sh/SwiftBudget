//
//  LoginViewController.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    let loginScreen = LoginPage()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
        
    override func loadView() {
        view = loginScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        loginScreen.submitButton.addTarget(self, action: #selector(onSigninTapped), for: .touchUpInside)
        loginScreen.signupButton.addTarget(self, action: #selector(onSignupTapped), for: .touchUpInside)
    }
    
    @objc func onSigninTapped() {
        if let email = loginScreen.emailField.text,
           let password = loginScreen.passwordField.text{
            //MARK: authenticating the user...
            Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
                if error == nil{
                    //MARK: user authenticated...
                    //MARK: Change what screen to push to later
                    NotificationCenter.default.post(name: NSNotification.Name("LoginSuccessful"), object: nil)
                    self.navigationController?.popViewController(animated: true)
                    print("User Logged in")
                }else{
                    //MARK: TODO: Create alert to notify no user found or password wrong...
                    print("No User Found")
                }
            })
        }
    }
    
    @objc func onSignupTapped() {
        let signupPage = SignupViewController()
        self.navigationController?.pushViewController(signupPage, animated: true)
    }
}
