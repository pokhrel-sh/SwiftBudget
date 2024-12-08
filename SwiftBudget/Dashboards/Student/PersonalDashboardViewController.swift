import UIKit
import FirebaseAuth
import FirebaseFirestore

class PersonalDashboardViewController: UIViewController {

    let dashboard = PersonalDashboard()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var currentUser: FirebaseAuth.User?
    
    let database = Firestore.firestore()
    
    var totalIncome = 0.0
    var totalExpense = 0.0
    var balance = 0.0
    var name: String?
    var email: String?
    
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
                
                self.listenToExpenses()
 
                self.listenToIncome()
            }
        }
    }
    
    func listenToExpenses() {
        self.database.collection("expenses")
            .whereField("for_user", isEqualTo: (self.currentUser?.email)!)
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error.localizedDescription)")
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    self.totalExpense = 0.0
                    for document in documents {
                        if let price = document.data()["price"] as? Double {
                            self.totalExpense += price
                            print("Updated Total Expense: \(self.totalExpense)")
                        }
                    }
                    
                    // Update the UI after expenses are fetched
                    DispatchQueue.main.async {
                        self.dashboard.totalExpenseValue.text = "$\(self.totalExpense)"
                        self.dashboard.netIncomeValue.text = "$\(self.totalIncome - self.totalExpense)"
                    }
                }
            }
    }
    
    func listenToIncome() {
        self.database.collection("budget")
            .whereField("for_user", isEqualTo: (self.currentUser?.email)!)
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                if let error = error {
                    print("Error fetching income: \(error.localizedDescription)")
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    self.totalIncome = 0.0
                    print("documents")
                    for document in documents {
                        if let amount = document.data()["amount"] as? Double {
                            self.totalIncome += amount
                            print("Updated Total Income: \(self.totalIncome)")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.dashboard.totalIncomeValue.text = "$\(self.totalIncome)"
                        self.dashboard.netIncomeValue.text = "$\(self.totalIncome - self.totalExpense)"
                    }
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Summary!"
        
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

