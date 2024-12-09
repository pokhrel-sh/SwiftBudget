//
//  DashboardViewController.swift
//  SwiftBudget
//
//  Created by Akshay Tolani on 12/7/24.
//


import UIKit
import Firebase
import FirebaseAuth

class DashboardViewController: UIViewController, UITableViewDataSource {
    
    var expenses: [Expense] = []
    var dashboardView = DashboardView()
    
    var overrideEmail: String?
    

    override func loadView() {
        view = dashboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExpenses()
        
        dashboardView.tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
        dashboardView.tableView.dataSource = self
    }
    

    
   
    // MARK: - Loading and fethcing transactions
    func loadTransactions() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else { return }
        fetchExpenses(email: overrideEmail ?? currentUserEmail)
        print(self.overrideEmail)
        print(currentUserEmail)
    }
    func fetchExpenses(email: String) {
        let db = Firestore.firestore()
        // Query Firebase for expenses added by the current user
        db.collection("expenses")
            .whereField("for_user", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error)")
                } else {
                    self.expenses = snapshot?.documents.compactMap { document -> Expense? in
                        let data = document.data()
                        let name = data["name"] as? String ?? ""
                        let price = data["price"] as? Double ?? 0
                        let date = data["date"] as? String ?? ""
                        let image = data["image"] as? String ?? ""
                        let addedBy = data["addedBy"] as? String ?? ""
                        return Expense(name: name, price: price, date: Date(), image: image, addedBy: addedBy, for_user: email)
                    } ?? []
                    
                     self.dashboardView.tableView.reloadData()
                }
            }
    }
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseTableViewCell
        let expense = expenses[indexPath.row]
        let currDate = Date()
        cell.labelName.text = expense.name
        cell.labelPrice.text = "$\(expense.price)"
        cell.labelDate.text = "Date: \(currDate)"
        cell.labelAddedBy.text = "Added by: \(expense.addedBy)"
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
