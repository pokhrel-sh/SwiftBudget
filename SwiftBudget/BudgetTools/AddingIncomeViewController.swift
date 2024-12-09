//
//  AddingIncomeViewController.swift
//  SwiftBudget
//
//  Created by Atif Agboatwala on 12/7/24.
//

import UIKit
import Firebase
import FirebaseAuth

class AddingIncomeViewController: UIViewController {
    
    let addIncomePage = AddingIncome()
    var selectedChild: String? // Track the selected child
    var currentUser: FirebaseAuth.User?
    var SelectedUser: String?
    let database = Firestore.firestore()
    
    var role: String?
    
    
    override func loadView() {
        view = addIncomePage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Adding Income Page"
        
        setupCurrentUser()
    
        addIncomePage.addIncomeButton.addTarget(self, action: #selector(saveIncome), for: .touchUpInside)
    }
    
    func setupCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
        }
        fetchUserRole(email: self.currentUser?.email ?? "")
    }
    
    func fetchUserRole(email: String) {
       
        database.collection("users2").document((self.currentUser?.uid)!).getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let role = data?["role"] as? String ?? "Parent"
                
                print("FetchUserRole: \(role)") // Check what role is fetched
                
                if role == "Kid" {
                    self.SelectedUser = email
                    print("Role is kid and email is: \(email)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @objc func saveIncome() {
        guard let name = addIncomePage.incomeNameTextField.text, !name.isEmpty,
              let desc = addIncomePage.incomeDescriptionTextField.text, !desc.isEmpty,
              let incomeAmount = addIncomePage.incomeTextField.text,
              let income = Double(incomeAmount), !incomeAmount.isEmpty,
              let addedBy = self.currentUser?.email, let selected = self.SelectedUser else {
            
            showError("Please fill all fields correctly.")
            return
        }
        
        if self.role == "Kid" {
            let newIncome = Transaction(type: "income", name: name, amount: income, desc: desc, date: Date(), image: "", addedBy: addedBy, for_user: selected)
            saveToFirebase(income: newIncome)

        } else {
            let newIncome = Transaction(type: "income", name: name, amount: income, desc: desc, date: Date(), image: "", addedBy: addedBy, for_user: addedBy)
            saveToFirebase(income: newIncome)

        }
    }
    
    func saveToFirebase(income: Transaction) {

        database.collection("transactions").addDocument(data: [
            "type": income.type,
            "name": income.name,
            "amount": income.amount,
            "desc": income.desc,
            "date": income.date,
            "image": income.image,
            "addedBy": income.addedBy,
            "for_user": income.for_user
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
