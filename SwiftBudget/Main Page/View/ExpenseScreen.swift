//
//  ExpenseScreen.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit

class ExpenseScreen: UIView {
    var addStudent: UIButton!
    var tableViewExpense: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupTableViewExpense()
        initConstraints()
    }
    
    func setupLabelText(){
        addStudent = UIButton(type: .system)
        addStudent.setTitle("add student", for: .normal)
        addStudent.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addStudent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addStudent)
    }
    
    func setupTableViewExpense(){
        tableViewExpense = UITableView()
        tableViewExpense.register(ExpenseTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewExpense)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            addStudent.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            addStudent.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            tableViewExpense.topAnchor.constraint(equalTo: addStudent.bottomAnchor, constant: 8),
            tableViewExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
