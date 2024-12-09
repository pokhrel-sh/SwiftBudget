//
//  ExpenseScreen.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit

class ExpenseScreen: UIView {
    var addExpense: UIButton!
    var tableViewExpense: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupAddExpenseButton()
        setupTableViewExpense()
        initConstraints()
    }

    func setupAddExpenseButton() {
        addExpense = UIButton(type: .system)
        addExpense.setTitle("Add Expense", for: .normal)
        addExpense.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addExpense)
    }
    
    func setupTableViewExpense() {
        tableViewExpense = UITableView()
        tableViewExpense.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "ExpenseCell")
        tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewExpense)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            addExpense.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            addExpense.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            tableViewExpense.topAnchor.constraint(equalTo: addExpense.bottomAnchor, constant: 8),
            tableViewExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
