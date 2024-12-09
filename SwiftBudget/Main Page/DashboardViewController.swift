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
    var tableView: UITableView!
    var addExpenseButton: UIButton!
    var overrideEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadTransactions()
    }
    
    // MARK: - Setup UI Elements
    func setupUI() {
        self.view.backgroundColor = .white
        
        // Setup Add Expense Button
        addExpenseButton = UIButton(type: .system)
        addExpenseButton.setTitle("Do Not Press", for: .normal)
        addExpenseButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addExpenseButton.translatesAutoresizingMaskIntoConstraints = false
        addExpenseButton.addTarget(self, action: #selector(addExpenseTapped), for: .touchUpInside)
        self.view.addSubview(addExpenseButton)
        
        // Setup TableView for Expenses
        tableView = UITableView()
        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        // Set up constraints
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Add Expense Button
            addExpenseButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addExpenseButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // TableView for Expenses
            tableView.topAnchor.constraint(equalTo: addExpenseButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
        ])
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
                    
                    self.tableView.reloadData()
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
