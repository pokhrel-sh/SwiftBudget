//
//  ParentDashboardViewController.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/8/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ParentDashboardViewController: UIViewController {
    
    let dashboard = ParentDashboard()
    
    var familyList = [FamilyCircle]()
    
    var parentName = ""
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser:FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = dashboard
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                print("User == nil")
                //MARK: Reset tableView...
                self.familyList.removeAll()
                self.dashboard.tableView.reloadData()
                
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                self.currentUser = user
                
                //MARK: the user is signed in...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the family list...
                self.database.collection("users2")
                .whereField("parentEmail", isEqualTo: (self.currentUser?.email)!)
                .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                    if let documents = querySnapshot?.documents{
                        self.familyList.removeAll()
                                                
                        for document in documents {
                            do {
                                var student = try document.data(as: FamilyCircle.self)
                                
                                self.listenToTransaction(student: student.email) { balance in
                                    student.balance = balance
                                    self.familyList.append(student)
                                    self.dashboard.tableView.reloadData()
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                })
            }
        }
    }
    
    func listenToTransaction(student: String, completion: @escaping (Double) -> Void) {
        self.database.collection("transactions")
        .whereField("for_user", isEqualTo: student)
        .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
            if let error = error {
                print("Error fetching expenses: \(error.localizedDescription)")
                completion(0.0)
                return
            }
                
            if let documents = querySnapshot?.documents {
                var totalExpense = 0.0
                var totalIncome = 0.0
                
                for document in documents {
                    if let type = document.data()["type"] as? String,
                       let amount = document.data()["amount"] as? Double {
                        if type == "expense" {
                            totalExpense += amount
                        } else {
                            totalIncome += amount
                        }
                    }
                }
                
                let balance = totalIncome - totalExpense
                completion(balance)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome \(self.parentName)!"
        
        self.navigationItem.hidesBackButton = true

        //MARK: patching table view delegate and data source...
        dashboard.tableView.delegate = self
        dashboard.tableView.dataSource = self
        
        //MARK: removing the separator line...
        dashboard.tableView.separatorStyle = .none
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}
