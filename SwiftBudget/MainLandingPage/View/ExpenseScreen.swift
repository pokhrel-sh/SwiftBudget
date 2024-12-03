//
//  ExpenseScreen.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit

class ExpenseScreen: UIView {
    var labelText: UILabel!
    var floatingButtonAddExpense: UIButton!
    var tableViewExpense: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelText()
        setupFloatingButtonAddExpense()
        setupTableViewExpense()
        initConstraints()
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewExpense(){
        tableViewExpense = UITableView()
        tableViewExpense.register(ExpenseTableViewCell.self, forCellReuseIdentifier: Configs.tableViewContactsID)
        tableViewExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewExpense)
    }
    
    func setupFloatingButtonAddExpense(){
        floatingButtonAddExpense = UIButton(type: .system)
        floatingButtonAddExpense.setTitle("", for: .normal)
        floatingButtonAddExpense.contentHorizontalAlignment = .fill
        floatingButtonAddExpense.contentVerticalAlignment = .fill
        floatingButtonAddExpense.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddExpense.layer.cornerRadius = 16
        floatingButtonAddExpense.imageView?.layer.shadowOffset = .zero
        floatingButtonAddExpense.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddExpense.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddExpense.imageView?.clipsToBounds = true
        floatingButtonAddExpense.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddExpense)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tableViewExpense.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewExpense.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddExpense.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddExpense.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddExpense.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddExpense.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
