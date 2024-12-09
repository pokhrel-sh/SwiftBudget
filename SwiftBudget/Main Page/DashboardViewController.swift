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
        fetchExpenses()
    }
    
    // MARK: - Setup UI Elements
    func setupUI() {
        self.view.backgroundColor = .white
        
        // Setup Add Expense Button
        addExpenseButton = UIButton(type: .system)
        addExpenseButton.setTitle("Add Expense", for: .normal)
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
    
    // MARK: - Fetch Expenses from Firebase
    func fetchExpenses() {
        let db = Firestore.firestore()
        let currentUserEmail = overrideEmail ?? Auth.auth().currentUser?.email
        
        guard let email = currentUserEmail else { return }
        
        db.collection("expenses")
            .whereField("for_user", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching expenses: \(error)")
                    return
                }
                
                self.expenses = snapshot?.documents.compactMap { document -> Expense? in
                    let data = document.data()
                    return Expense(
                        name: data["name"] as? String ?? "",
                        price: data["price"] as? Double ?? 0.0,
                        date: Date(), // Convert to Date if stored as a String
                        image: data["image"] as? String ?? "",
                        addedBy: data["addedBy"] as? String ?? "",
                        for_user: data["for_user"] as? String ?? ""
                    )
                } ?? []
                
                DispatchQueue.main.async {
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
