import UIKit
import FirebaseAuth
import FirebaseFirestore

class PersonalDashboardViewController: UIViewController {

    let dashboard = PersonalDashboard()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser: FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    var startDate = Date()
    var totalIncome = 0.0
    var totalExpense = 0.0
    var name: String?
    var email: String?
    var role: String?
    
    override func loadView() {
        view = dashboard
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Handling authentication state change
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                // User is not signed in
                print("User == nil")
                self.setupRightBarButton(isLoggedin: false)
            } else {
                self.currentUser = user
                
                self.setupRightBarButton(isLoggedin: true)
                
                self.database.collection("transactions")
                    .whereField("for_user", isEqualTo: (self.currentUser?.email)!)
                    .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                        if let error = error {
                            print("Error fetching expenses: \(error.localizedDescription)")
                            return
                        }
                        
                        if let documents = querySnapshot?.documents {
                            self.totalExpense = 0.0
                            self.totalIncome = 0.0
                            for document in documents {
                                
                                if let timestamp = document.data()["date"] as? Timestamp {
                                    let date = timestamp.dateValue()
                                    if self.startDate > date {
                                        self.startDate = date
                                    }
                                }
                                 
                                if let type = document.data()["type"] as? String,
                                   let amount = document.data()["amount"] as? Double {
                                    if type == "expense" {
                                        self.totalExpense += amount
                                    } else {
                                        self.totalIncome += amount
                                    }
                                }
                            }
                                
                            DispatchQueue.main.async {
                                self.dashboard.totalExpenseValue.text = "$\(self.totalExpense)"
                                self.dashboard.totalIncomeValue.text = "$\(self.totalIncome)"
                                self.dashboard.netIncomeValue.text = "$\(self.totalIncome - self.totalExpense)"
                                self.dashboard.startDate.text = "Start Date: \(self.startDate.formatted(date: .numeric, time: .omitted))"
                            }
                        }
                    }
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Summary Page!"
        
        self.navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        dashboard.name.text = "Name: \(name ?? "Error Loading Name")"
        dashboard.email.text = "Email: \(email ?? "Error Loading Email")"
        
        dashboard.addIncomeButton.addTarget(self, action: #selector(addIncomeTapped), for: .touchUpInside)
        dashboard.addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
        dashboard.viewTransactions.addTarget(self, action: #selector(viewTransactionTapped), for: .touchUpInside)
    }
    
    @objc func viewTransactionTapped() {
        let transactions = DashboardViewController()
        navigationController?.pushViewController(transactions, animated: true)
    }
    
    @objc func addIncomeTapped() {
        let incomePage = AddingIncomeViewController()
        navigationController?.pushViewController(incomePage, animated: true)
    }
    
    @objc func addExpenseTapped() {
        let expensePage = AddingExpenseViewController()
        navigationController?.pushViewController(expensePage, animated: true)
    }
}

