//
//  DashboardView.swift
//  SwiftBudget
//
//  Created by Akshay Tolani on 12/8/24.
//

import UIKit

class DashboardView: UIView {
    
    var dashboardTitle: UILabel!
    
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupDashboardLabel()
        
        setupTableView()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDashboardLabel() {
        dashboardTitle = UILabel()
        dashboardTitle.text = "Transaction history"
        dashboardTitle.font = UIFont.systemFont(ofSize: 16)
        dashboardTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dashboardTitle)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            dashboardTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            dashboardTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            // TableView for Expenses
            tableView.topAnchor.constraint(equalTo: dashboardTitle.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
}
