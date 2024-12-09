import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    let loginScreen = LoginPage()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let db = Firestore.firestore()

    override func loadView() {
        view = loginScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Handling authentication state changes
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.currentUser = user
                print("User is signed in: \(user.email ?? "No Email")")
            } else {
                self.currentUser = nil
                print("No user is signed in.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginScreen.submitButton.addTarget(self, action: #selector(onSigninTapped), for: .touchUpInside)
        loginScreen.signupButton.addTarget(self, action: #selector(onSignupTapped), for: .touchUpInside)
    }
    
    @objc func onSigninTapped() {
        guard let email = loginScreen.emailField.text, !email.isEmpty,
              let password = loginScreen.passwordField.text, !password.isEmpty else {
            // Show alert for empty fields
            showAlert(title: "Error", message: "Please enter email and password.")
            return
        }
        
        // Authenticating the user
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle login error
                self.showAlert(title: "Login Failed", message: error.localizedDescription)
                print("Login error: \(error.localizedDescription)")
            } else if let user = result?.user {
                // Fetch user details from Firestore 'users2' collection
                self.db.collection("users2").document(user.uid).getDocument { snapshot, error in
                    if let error = error {
                        print("Error fetching user details: \(error.localizedDescription)")
                        self.showAlert(title: "Error", message: "Failed to fetch user details.")
                    } else if let snapshot = snapshot, snapshot.exists {
                        
                        
                        if let data = snapshot.data() {
                            // Access a specific field
                            if let role = data["role"] as? String, let name = data["name"] as? String, let email = data["email"] as? String{
                                if role == "Parent" {
                                    let ParentDashboard = ParentDashboardViewController()
                                    ParentDashboard.parentName = name
                                    self.navigationController?.pushViewController(ParentDashboard, animated: true)
                                } else {
                                    let personalDashboard = PersonalDashboardViewController()
                                    personalDashboard.name = name
                                    personalDashboard.email = email
                                    personalDashboard.role = role
                                    self.navigationController?.pushViewController(personalDashboard, animated: true)
                                }
                            } else {
                                print("Role not found")
                            }
                        }
                        
                        // Successfully fetched user details
                        print("User details: \(snapshot.data() ?? [:])")
                        
                        print("User logged in successfully.")
                        
                        
                        
                        
                    } else {
                        self.showAlert(title: "Error", message: "User details not found in Firestore.")
                    }
                }
            }
        }
    }
    
    @objc func onSignupTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Helper function to show alerts
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
