//
//  ParentDashboard.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/8/24.
//

import UIKit

class ParentDashboard: UIView {
    
    var labelList: UILabel!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupTableViewFamily()
        setupConstraints()
    }
    
    func setupLabelName(){
        labelList = UILabel()
        labelList.text = "Select a dependent to view their transaction history"
        labelList.font = UIFont.systemFont(ofSize: 12)
        labelList.lineBreakMode = .byWordWrapping
        labelList.translatesAutoresizingMaskIntoConstraints = false
        labelList.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelList)
    }
    
    func setupTableViewFamily(){
        tableView = UITableView()
        tableView.register(ParentDashboardTableViewCell.self, forCellReuseIdentifier: Configs.tableViewStudentsID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelList.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelList.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: labelList.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
