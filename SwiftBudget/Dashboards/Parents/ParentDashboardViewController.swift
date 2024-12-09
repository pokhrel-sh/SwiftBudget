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
                
                self.dashboard.labelAdd.isEnabled = true
                self.dashboard.labelAdd.isHidden = false
                
                //MARK: the user is signed in...
                self.setupRightBarButton(isLoggedin: true)
    
                //MARK: Observe Firestore database to display the family list...
                self.database.collection("users2")
                    .whereField("parentEmail", isEqualTo: (self.currentUser?.email)!)// Maybe dont force unwrap
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.familyList.removeAll()
                            for document in documents{
                                do{
                                    let student  = try document.data(as: FamilyCircle.self)
                                    self.familyList.append(student)
                                }catch{
                                    print(error)
                                }
                            }
                            self.dashboard.tableView.reloadData()
                        }
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome!"
        
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
