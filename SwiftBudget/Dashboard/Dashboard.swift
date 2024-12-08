//
//  DashBoard.swift
//  SwiftBudget
//
//  Created by Shishir Pokhrel on 12/2/24.
//
import UIKit

class ViewController: UIViewController {

    //Below are the things that changes based on user informations
    var name: UILabel!
    var email: UILabel!
    var totalIncomeValue: UILabel!
    var netIncomeValue: UILabel!
    var totalExpenseValue: UILabel!
    var startDate: UILabel!
    
    
    //Below are NON-MUTABLE elements
    var summaryTitle: UILabel!
    var endDate: UILabel!
    var totalIncomeLabel: UILabel!
    var totalExpenseLabel: UILabel!
    var netIncomeLabel: UILabel!
    var addIncomeButton: UIButton!
    var addExpenseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupName()
        setupEmail()
        setupSummaryTitle()
        setupStartDate()
        setupEndDate()
        setupTotalIncome()
        setupTotalExpense()
        setupNetIncome()
        setupButtons()
        
        initConstraints()
    }
    
    func setupName() {
        name = UILabel()
        name.text = "Name: John Doe"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
    }
    
    func setupEmail() {
        email = UILabel()
        email.text = "Email: john.doe@example.com"
        email.textColor = .darkGray
        email.font = UIFont.systemFont(ofSize: 16)
        email.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(email)
    }
    
    func setupSummaryTitle() {
        summaryTitle = UILabel()
        summaryTitle.text = "Summary"
        summaryTitle.textColor = .black
        summaryTitle.font = UIFont.boldSystemFont(ofSize: 24)
        summaryTitle.textAlignment = .center
        summaryTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryTitle)
    }
    
    func setupStartDate() {
        startDate = UILabel()
        startDate.text = "Start Date: N/A"
        startDate.textColor = .darkGray
        startDate.font = UIFont.systemFont(ofSize: 16)
        startDate.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startDate)
    }
    
    func setupEndDate() {
        endDate = UILabel()
        endDate.text = "End Date: Today"
        endDate.textColor = .darkGray
        endDate.font = UIFont.systemFont(ofSize: 16)
        endDate.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endDate)
    }
    
    func setupTotalIncome() {
        totalIncomeLabel = UILabel()
        totalIncomeLabel.text = "Total Income:"
        totalIncomeLabel.textColor = .black
        totalIncomeLabel.font = UIFont.systemFont(ofSize: 18)
        totalIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalIncomeLabel)
        
        totalIncomeValue = UILabel()
        totalIncomeValue.text = "$0.00"
        totalIncomeValue.textColor = .green
        totalIncomeValue.font = UIFont.boldSystemFont(ofSize: 18)
        totalIncomeValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalIncomeValue)
    }
    
    func setupTotalExpense() {
        totalExpenseLabel = UILabel()
        totalExpenseLabel.text = "Total Expense:"
        totalExpenseLabel.textColor = .black
        totalExpenseLabel.font = UIFont.systemFont(ofSize: 18)
        totalExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalExpenseLabel)
        
        totalExpenseValue = UILabel()
        totalExpenseValue.text = "$0.00"
        totalExpenseValue.textColor = .red
        totalExpenseValue.font = UIFont.boldSystemFont(ofSize: 18)
        totalExpenseValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalExpenseValue)
    }
    
    func setupNetIncome() {
        netIncomeLabel = UILabel()
        netIncomeLabel.text = "Net Income:"
        netIncomeLabel.textColor = .black
        netIncomeLabel.font = UIFont.systemFont(ofSize: 18)
        netIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netIncomeLabel)
        
        netIncomeValue = UILabel()
        netIncomeValue.text = "$0.00"
        netIncomeValue.textColor = .blue
        netIncomeValue.font = UIFont.boldSystemFont(ofSize: 18)
        netIncomeValue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(netIncomeValue)
    }
    
    func setupButtons() {
        addIncomeButton = UIButton(type: .system)
        addIncomeButton.setTitle("Add Income", for: .normal)
        addIncomeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addIncomeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addIncomeButton)
        
        addExpenseButton = UIButton(type: .system)
        addExpenseButton.setTitle("Add Expense", for: .normal)
        addExpenseButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addExpenseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addExpenseButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            summaryTitle.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            summaryTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startDate.topAnchor.constraint(equalTo: summaryTitle.bottomAnchor, constant: 20),
            startDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            endDate.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 10),
            endDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            totalIncomeLabel.topAnchor.constraint(equalTo: endDate.bottomAnchor, constant: 30),
            totalIncomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            totalIncomeValue.centerYAnchor.constraint(equalTo: totalIncomeLabel.centerYAnchor),
            totalIncomeValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            totalExpenseLabel.topAnchor.constraint(equalTo: totalIncomeLabel.bottomAnchor, constant: 20),
            totalExpenseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            totalExpenseValue.centerYAnchor.constraint(equalTo: totalExpenseLabel.centerYAnchor),
            totalExpenseValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            netIncomeLabel.topAnchor.constraint(equalTo: totalExpenseLabel.bottomAnchor, constant: 20),
            netIncomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            netIncomeValue.centerYAnchor.constraint(equalTo: netIncomeLabel.centerYAnchor),
            netIncomeValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addIncomeButton.topAnchor.constraint(equalTo: netIncomeLabel.bottomAnchor, constant: 40),
            addIncomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            addExpenseButton.topAnchor.constraint(equalTo: netIncomeLabel.bottomAnchor, constant: 40),
            addExpenseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
}
