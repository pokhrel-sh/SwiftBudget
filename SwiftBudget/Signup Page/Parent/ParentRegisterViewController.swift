//
//  ParentRegisterViewController.swift
//  SwiftBudget
//
//  Created by Akshay Tolani on 12/7/24.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class ParentRegisterViewController: UIViewController {
    
    let parentView = ParentSignUpView()
    
    private let db = Firestore.firestore()
    
    override func loadView() {
        view = parentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        parentView.registerButton.addTarget(self, action: #selector(registerParent), for: .touchUpInside)
    }


    @objc private func registerParent() {
        guard let name = parentView.nameField.text, !name.isEmpty,
              let email = parentView.emailField.text?.lowercased(),
              let password = parentView.passwordField.text, !password.isEmpty else {
            showAlert("Please fill in all fields.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert("Registration failed: \(error.localizedDescription)")
                return
            }

            guard let uid = authResult?.user.uid else {
                self.showAlert("Failed to retrieve user ID.")
                return
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.db.collection("users2").document(uid).setData([
                "name": name,
                "email": email,
                "role": "Parent"
            ]) { error in
                if let error = error {
                    self.showAlert("Database error: \(error.localizedDescription)")
                } else {
                    dispatchGroup.leave()

                }
            }
            
            dispatchGroup.enter()
            self.db.collection("familyCircle").document(uid).setData([
                "name": name,
                "email": email,
                "kids": [],
            ])  { error in
                if let error = error {
                    self.showAlert("Database error: \(error.localizedDescription)")
                } else {
                    dispatchGroup.leave()

                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.showAlert("Parent registration successful!", action: {
                    //self.navigationController?.pushViewController(DashboardViewController(), animated: true)
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }

    private func showAlert(_ message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in action?() })
        present(alert, animated: true)
    }
}
