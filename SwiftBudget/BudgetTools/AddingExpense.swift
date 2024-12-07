//
//  ViewController.swift
//  ExpenseTracker
//
//  Created by [Your Name] on [Date].
//

import UIKit

class AddingExpense: UIView {
    
    var expenseTitle: UILabel!
    var addExpenseLabel: UILabel!
    var expenseAmountTextField: UITextField!
    var expenseNameLabel: UILabel!
    var expenseNameTextField: UITextField!
    var expenseDescriptionLabel: UILabel!
    var expenseDescriptionTextField: UITextField!
    var addExpenseButton: UIButton!
    var viewAllExpensesButton: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupExpenseTitle()
        setupAddExpenseLabel()
        setupExpenseAmountTextField()
        setupExpenseNameLabel()
        setupExpenseNameTextField()
        setupExpenseDescriptionLabel()
        setupExpenseDescriptionTextField()
        setupAddExpenseButton()
        setupViewAllExpensesButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupExpenseTitle() {
        expenseTitle = UILabel()
        expenseTitle.text = "Expense Tracker"
        expenseTitle.textAlignment = .center
        expenseTitle.font = UIFont.boldSystemFont(ofSize: 24)
        expenseTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseTitle)
    }
    
    private func setupAddExpenseLabel() {
        addExpenseLabel = UILabel()
        addExpenseLabel.text = "How much did you spend?"
        addExpenseLabel.font = UIFont.systemFont(ofSize: 18)
        addExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addExpenseLabel)
    }
    
    private func setupExpenseAmountTextField() {
        expenseAmountTextField = UITextField()
        expenseAmountTextField.placeholder = "Enter Expense Amount"
        expenseAmountTextField.borderStyle = .roundedRect
        expenseAmountTextField.keyboardType = .numberPad
        expenseAmountTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseAmountTextField)
    }
    
    private func setupExpenseNameLabel() {
        expenseNameLabel = UILabel()
        expenseNameLabel.text = "What did you spend it on?"
        expenseNameLabel.font = UIFont.systemFont(ofSize: 18)
        expenseNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseNameLabel)
    }
    
    private func setupExpenseNameTextField() {
        expenseNameTextField = UITextField()
        expenseNameTextField.placeholder = "Expense Name"
        expenseNameTextField.borderStyle = .roundedRect
        expenseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseNameTextField)
    }
    
    private func setupExpenseDescriptionLabel() {
        expenseDescriptionLabel = UILabel()
        expenseDescriptionLabel.text = "Elaborate the spending"
        expenseDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        expenseDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseDescriptionLabel)
    }
    
    private func setupExpenseDescriptionTextField() {
        expenseDescriptionTextField = UITextField()
        expenseDescriptionTextField.placeholder = "Enter Description"
        expenseDescriptionTextField.borderStyle = .roundedRect
        expenseDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseDescriptionTextField)
    }
    
    private func setupAddExpenseButton() {
        addExpenseButton = UIButton(type: .system)
        addExpenseButton.setTitle("Add Expense", for: .normal)
        addExpenseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addExpenseButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addExpenseButton)
    }
    
    private func setupViewAllExpensesButton() {
        viewAllExpensesButton = UIButton(type: .system)
        viewAllExpensesButton.setTitle("View All Expenses", for: .normal)
        viewAllExpensesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        viewAllExpensesButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewAllExpensesButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            // Expense Title
            expenseTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            expenseTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Add Expense Label
            addExpenseLabel.topAnchor.constraint(equalTo: expenseTitle.bottomAnchor, constant: 20),
            addExpenseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Expense Amount TextField
            expenseAmountTextField.topAnchor.constraint(equalTo: addExpenseLabel.bottomAnchor, constant: 10),
            expenseAmountTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseAmountTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseAmountTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Expense Name Label
            expenseNameLabel.topAnchor.constraint(equalTo: expenseAmountTextField.bottomAnchor, constant: 20),
            expenseNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Expense Name TextField
            expenseNameTextField.topAnchor.constraint(equalTo: expenseNameLabel.bottomAnchor, constant: 10),
            expenseNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Expense Description Label
            expenseDescriptionLabel.topAnchor.constraint(equalTo: expenseNameTextField.bottomAnchor, constant: 20),
            expenseDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Expense Description TextField
            expenseDescriptionTextField.topAnchor.constraint(equalTo: expenseDescriptionLabel.bottomAnchor, constant: 10),
            expenseDescriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseDescriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseDescriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Add Expense Button
            addExpenseButton.topAnchor.constraint(equalTo: expenseDescriptionTextField.bottomAnchor, constant: 30),
            addExpenseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // View All Expenses Button
            viewAllExpensesButton.topAnchor.constraint(equalTo: addExpenseButton.bottomAnchor, constant: 20),
            viewAllExpensesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
