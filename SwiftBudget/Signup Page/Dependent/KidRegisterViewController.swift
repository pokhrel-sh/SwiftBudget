import UIKit
import FirebaseAuth
import FirebaseFirestore

class KidRegisterViewController: UIViewController {
    
    let kidView = KidSignUpView()
    private let db = Firestore.firestore()

    override func loadView() {
        view = kidView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Connect the button to the registerKid method
        kidView.registerButton.addTarget(self, action: #selector(registerKid), for: .touchUpInside)
    }

    @objc private func registerKid() {
        guard let name = kidView.nameField.text, !name.isEmpty,
              let email = kidView.emailField.text?.lowercased(),
              let password = kidView.passwordField.text, !password.isEmpty,
              let parentEmail = kidView.parentEmailField.text?.lowercased(), !parentEmail.isEmpty else {
            showAlert("Please fill in all fields.")
            return
        }

        // Validate parent email
        validateParentEmail(parentEmail) { [weak self] isValid in
            guard let self = self else { return }

            if isValid {
                self.createUser(name: name, email: email, password: password, parentEmail: parentEmail)
            } else {
                self.showAlert("Parent email does not exist.")
            }
        }
    }

    private func validateParentEmail(_ email: String, completion: @escaping (Bool) -> Void) {
        db.collection("users2").whereField("email", isEqualTo: email).whereField("role", isEqualTo: "Parent").getDocuments { snapshot, error in
            if let error = error {
                print("Error validating parent email: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(snapshot?.documents.count ?? 0 > 0)
            }
        }
    }

    private func createUser(name: String, email: String, password: String, parentEmail: String) {
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

            // Save user data to Firestore
            let userData = [
                "name": name,
                "email": email,
                "role": "Kid",
                "parentEmail": parentEmail
            ]

            self.db.collection("users2").document(uid).setData(userData) { error in
                if let error = error {
                    self.showAlert("Database error: \(error.localizedDescription)")
                    return
                }
            }

            self.db.collection("familyCircle").whereField("email", isEqualTo: parentEmail)
                .getDocuments { snapshot, error in
                    if let error = error {
                        self.showAlert("Error finding family circle: \(error.localizedDescription)")
                        return
                    }

                    if let familyDoc = snapshot?.documents.first {
                        // Parent found, now update the kids list
                        self.db.collection("familyCircle").document(familyDoc.documentID).updateData([
                            "kids": FieldValue.arrayUnion([email])
                        ]) { error in
                            if let error = error {
                                self.showAlert("Error adding kid to family circle: \(error.localizedDescription)")
                            } else {
                                self.showAlert("Registration successful!", action: {
                                    self.navigateToDashboard()
                                })
                            }
                        }
                    } else {
                        self.showAlert("Parent not found in family circle.")
                    }
                }
            
            // Save the budget data
            self.db.collection("budget").document(uid).setData([
                "email": email,
                "parent_email": parentEmail,
            ]) { error in
                if let error = error {
                    self.showAlert("Database error: \(error.localizedDescription)")
                }
            }
        }
    }


    private func navigateToDashboard() {
        self.navigationController?.popViewController(animated: true)
    }

    private func showAlert(_ message: String, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in action?() })
        present(alert, animated: true)
    }
}

