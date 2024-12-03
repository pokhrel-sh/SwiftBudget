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

class ViewController: UIViewController {
    let landingPage = LandingPage()
    let expenseScreen = ExpenseScreen()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = landingPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        
        //Assigns each button with a number used to assign the users role when signing up
        //These roles determine what screen the user sees after logging in
        landingPage.dependantButton.tag = 1
        landingPage.parentButton.tag = 2
        
        landingPage.dependantButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        landingPage.parentButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        landingPage.studentButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginSuccess), name: NSNotification.Name("LoginSuccessful"), object: nil)
    }
    
    @objc func onButtonTap(type: UIButton) {
        let loginScreen = LoginViewController()
        if type.tag == 1 {
            Configs.currRole = "dependent"
        }else if type.tag == 2 {
            Configs.currRole = "parent"
        }else {
            Configs.currRole = "student"
        }
        self.navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    @objc func handleLoginSuccess() {
        view = expenseScreen
        title = "Summary"
        //self.navigationController?.pushViewController(expenseScreen, animated: true)
    }
    
    //MARK: TODO: Implement logout button in summary page
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
            logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
