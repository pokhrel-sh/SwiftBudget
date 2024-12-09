//
//  StudentSignupViewController.swift
//  SwiftBudget
//
//  Created by Akshay Tolani on 12/7/24.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class StudentSignupViewController: UIViewController {
    
    let studentView = StudentSignUpView()
    private let db = Firestore.firestore()
    
    override func loadView() {
        view = studentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        studentView.registerButton.addTarget(self, action: #selector(registerStudent), for: .touchUpInside)
    }

    @objc private func registerStudent() {
        guard let name =  studentView.nameField.text, !name.isEmpty,
              let email = studentView.emailField.text?.lowercased(),
              let password = studentView.passwordField.text, !password.isEmpty else {
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

            self.db.collection("users2").document(uid).setData([
                "name": name,
                "email": email,
                "role": "Student"
            ]) { error in
                if let error = error {
                    self.showAlert("Database error: \(error.localizedDescription)")
                } else {
                    self.showAlert("Registration successful!", action: {
                        let dashboard = PersonalDashboardViewController()
                        self.navigationController?.pushViewController(dashboard, animated: true)
                    })
                }
            }
        }
    }

    private func showAlert(_ message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in action?() })
        present(alert, animated: true)
    }
}
