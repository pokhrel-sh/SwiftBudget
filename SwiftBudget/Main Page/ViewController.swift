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
        landingPage.parentButton.tag = 1
        
        landingPage.dependantButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        landingPage.parentButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        landingPage.studentButton.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginSuccess), name: NSNotification.Name("LoginSuccessful"), object: nil)
        
        expenseScreen.addStudent.addTarget(self, action: #selector(addStudentTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.setupRightBarButton(isLoggedin: true)
                
            }
        }
    }
    
    @objc func onButtonTap(type: UIButton) {
        let loginScreen = LoginViewController()
        
        if type.tag == 1 {
            Configs.currRole = .parent
        }else {
            Configs.currRole = .student
        }
        
        self.navigationController?.pushViewController(loginScreen, animated: true)
    }
    
    @objc func handleLoginSuccess() {
        view = expenseScreen
        title = "Summary"
    }
    
    @objc func addStudentTapped() {
        
        let createChatAlert = UIAlertController(
            title: "Add a dependent",
            message: "Who do you want to add to your family circle?",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        createChatAlert.addTextField{ textField in
            textField.placeholder = "Enter email"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }
        
        let createChatAction = UIAlertAction(title: "Add dependent", style: .default, handler: {(_) in
            if let email = createChatAlert.textFields![0].text{
               //let DependentViewController = DependentViewController() // TODO: Implement page
                //DependentViewController.studentEmail = email
                self.getUserId(email: email)
            }
        })
        
        createChatAlert.addAction(createChatAction)
        
        self.present(createChatAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            createChatAlert.view.superview?.isUserInteractionEnabled = true
            createChatAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    
    func getUserId(email: String) {
        let db = Firestore.firestore()
      
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
            } else {
                // Check if a document with the given email was found
                if let snapshot = querySnapshot, !snapshot.isEmpty {
                    // Assuming there's only one document with that email TODO: Implement Error Check
                    let document = snapshot.documents[0]
                    let studentId = document.documentID
                    
                    self.saveFamilyToFireStore(studentId: studentId)
                } else {
                    // No user found with the given email
                }
            }
        }
    }
    
    func saveFamilyToFireStore(studentId: String){
        
        // Generate a family circle ID
        let familyCircleId = UUID().uuidString
        let db = Firestore.firestore()
        if let parentID = Auth.auth().currentUser?.uid {
            // Save the role to Firestore
            db.collection("familyCircle").document(familyCircleId).setData([
                "parentId": parentID,
                "studentIds": FieldValue.arrayUnion([studentId])
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Family Circcle successfully updated to Firestore!")
                }
            }
        }
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }
}
