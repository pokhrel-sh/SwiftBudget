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
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        registerNewAccount()
    }
    
    func registerNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let name = signupScreen.nameField.text,
           let email = signupScreen.emailField.text,
           let password = signupScreen.passwordField.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    self.setUserInFirestore(name: name, email: email)

                }else{
                    //MARK: there is a error creating the user...
                    print(error)
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func setUserInFirestore(name: String, email: String){
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid

        let role = Configs.currRole

        // Save the role to Firestore
        db.collection("users").document(userID!).setData([
            "email": email,
            "familyCircleId": "",
            "name": name,
            "role": role
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("User successfully written to Firestore!")
            }
        }
    }
}
