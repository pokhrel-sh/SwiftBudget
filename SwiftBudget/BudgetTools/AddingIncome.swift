//
//  ViewController.swift
//
//  Adding budget income
//
//  Created by Shishir Pokhrel on 12/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    var incomeTitle: UILabel!
    var addIncomeLabel: UILabel!
    var incomeTextField: UITextField!
    var incomeName: UILabel!
    var incomeNameTextField: UITextField!
    var incomeDescription: UILabel!
    var incomeDescriptionTextField: UITextField!
    var addIncomeButton: UIButton!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIInit()
        initConstraints()
    }
    
    private func UIInit() {
        setupIncomeTitle()
        setupIncomeLabel()
        setupIncomeTextField()
        setupIncomeName()
        setupIncomeNameTextField()
        setupIncomeDescription()
        setupIncomeDescriptionTextField()
        setupAddIncomeButton()
        setupBackButton()
    }
    
    func setupIncomeTitle() {
        incomeTitle = UILabel()
        incomeTitle.text = "Income Tracker"
        incomeTitle.textAlignment = .center
        incomeTitle.font = UIFont.boldSystemFont(ofSize: 24)
        incomeTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeTitle)
    }
    
    func setupIncomeLabel() {
        addIncomeLabel = UILabel()
        addIncomeLabel.text = "How much do you want to add to budget?"
        addIncomeLabel.font = UIFont.systemFont(ofSize: 18)
        addIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addIncomeLabel)
    }
    
    func setupIncomeTextField() {
        incomeTextField = UITextField()
        incomeTextField.placeholder = "Enter Income Amount"
        incomeTextField.borderStyle = .roundedRect
        incomeTextField.keyboardType = .numberPad 
        incomeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeTextField)
    }
    
    func setupIncomeName() {
        incomeName = UILabel()
        incomeName.text = "Where is this money coming from?"
        incomeName.font = UIFont.systemFont(ofSize: 18)
        incomeName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeName)
    }
    
    func setupIncomeNameTextField() {
        incomeNameTextField = UITextField()
        incomeNameTextField.placeholder = "Income Name"
        incomeNameTextField.borderStyle = .roundedRect
        incomeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeNameTextField)
    }
    
    func setupIncomeDescription() {
        incomeDescription = UILabel()
        incomeDescription.text = "Elaborate the income"
        incomeDescription.font = UIFont.systemFont(ofSize: 16)
        incomeDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeDescription)
    }
    
    func setupIncomeDescriptionTextField() {
        incomeDescriptionTextField = UITextField()
        incomeDescriptionTextField.placeholder = "Enter Description"
        incomeDescriptionTextField.borderStyle = .roundedRect
        incomeDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(incomeDescriptionTextField)
    }
    
   func setupAddIncomeButton() {
        addIncomeButton = UIButton(type: .system)
        addIncomeButton.setTitle("Add Income", for: .normal)
        addIncomeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addIncomeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addIncomeButton)
    }
    
    func setupBackButton() {
        backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Income Title
            incomeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            incomeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Add Income Label
            addIncomeLabel.topAnchor.constraint(equalTo: incomeTitle.bottomAnchor, constant: 20),
            addIncomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Income TextField
            incomeTextField.topAnchor.constraint(equalTo: addIncomeLabel.bottomAnchor, constant: 10),
            incomeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incomeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            incomeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Name Label
            incomeName.topAnchor.constraint(equalTo: incomeTextField.bottomAnchor, constant: 20),
            incomeName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Income Name TextField
            incomeNameTextField.topAnchor.constraint(equalTo: incomeName.bottomAnchor, constant: 10),
            incomeNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incomeNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            incomeNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Description Label
            incomeDescription.topAnchor.constraint(equalTo: incomeNameTextField.bottomAnchor, constant: 20),
            incomeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Income Description TextField
            incomeDescriptionTextField.topAnchor.constraint(equalTo: incomeDescription.bottomAnchor, constant: 10),
            incomeDescriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            incomeDescriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            incomeDescriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Add Income Button
            addIncomeButton.topAnchor.constraint(equalTo: incomeDescriptionTextField.bottomAnchor, constant: 30),
            addIncomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Back Button
            backButton.centerYAnchor.constraint(equalTo: incomeTitle.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
