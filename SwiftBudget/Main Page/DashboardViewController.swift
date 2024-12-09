import UIKit
import Firebase
import FirebaseAuth

class DashboardViewController: UIViewController, UITableViewDataSource {
    
    var transactions: [Transaction] = []
    var dashboardView = DashboardView()
    
    var overrideEmail: String?
    

    override func loadView() {
        view = dashboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTransactions()
        
        dashboardView.tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
        dashboardView.tableView.dataSource = self
    }
    
   
    // MARK: - Loading and fethcing transactions
    func loadTransactions() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else { return }
        fetchExpenses(email: overrideEmail ?? currentUserEmail)
        print(currentUserEmail)
    }
    
    func fetchExpenses(email: String) {
        let db = Firestore.firestore()

        let currentUserEmail = overrideEmail ?? Auth.auth().currentUser?.email
        
        guard let email = currentUserEmail else { return }
        
        db.collection("transactions")
            .whereField("for_user", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error)")
                    return
                }
                
                self.transactions = snapshot?.documents.compactMap { document -> Expense? in
                    let data = document.data()
                    return Transaction(
                        type = data["type"] as? String ?? ""
                        name = data["name"] as? String ?? ""
                        price = data["amount"] as? Double ?? 0
                        desc = data["desc"] as? String ?? "N/A"
                        date = Date()
                        image = data["image"] as? String ?? ""
                        addedBy = data["addedBy"] as? String ?? ""
                        for_user = data["for_user"] as? String ?? ""
                    )
                } ?? []
                
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
                  self.dashboardView.tableView.reloadData()
                }
            }
    }
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseTableViewCell
        let expense = transactions[indexPath.row]
        let currDate = Date()
        
        cell.labelName.text = "\(expense.type.uppercased()): \(expense.name)"
        cell.labelPrice.text = "$\(expense.amount)"
        cell.labelDate.text = "Date: \(currDate)"
        cell.labelAddedBy.text = "Added by: \(expense.addedBy)"
        if let imageUrl = URL(string: expense.image), !expense.image.isEmpty {
                cell.expenseImageView.loadRemoteImage(from: imageUrl)
            } else {
                cell.expenseImageView.image = UIImage(systemName: "photo") // Placeholder image
            }
        // You can use the image URL for expense.image if required
        // e.g., load the image asynchronously using a library like SDWebImage
        
        return cell
    }
    
    // MARK: - Add Expense Button Action
    @objc func addExpenseTapped() {
        let addExpenseVC = AddingExpenseViewController()
        self.navigationController?.pushViewController(addExpenseVC, animated: true)
    }
}
