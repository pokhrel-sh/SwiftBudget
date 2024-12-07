//
//  SignupViewController.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
    
    @objc func onRegisterTapped() {
        // Validate the input fields before attempting to register
        guard let name = signupScreen.nameField.text, !name.isEmpty,
              let email = signupScreen.emailField.text, isValidEmail(email),
              let password = signupScreen.passwordField.text, password.count >= 6 else {
            showError("Please ensure all fields are filled in correctly.")
            return
        }
        
        // Register a new account
        registerNewAccount(name: name, email: email, password: password)
    }
    
    func registerNewAccount(name: String, email: String, password: String) {
        // Create a Firebase user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.showError("Failed to register: \(error.localizedDescription)")
                return
            }
            
            // Successful user creation
            self.setNameOfTheUserInFirebaseAuth(name: name)
            self.setUserInFirestore(name: name, email: email)
        }
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String) {
        // Update the user's display name in Firebase Auth
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if let error = error {
                self.showError("Error updating profile: \(error.localizedDescription)")
                return
            }
            
            // Navigate back to the previous screen after successful registration
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setUserInFirestore(name: String, email: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("Error: User ID is not available.")
            return
        }

        let db = Firestore.firestore()

        let role = Configs.currRole.rawValue

        db.collection("users").document(userID).setData([
            "email": email,
            "familyCircleId": "",
            "name": name,
            "role": role
        ]) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User successfully written to Firestore!")
            }
        }
    }
    // MARK: - Helper Functions
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

