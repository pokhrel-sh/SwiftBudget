//
//  ParentDashboard.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/8/24.
//

import UIKit

class ParentDashboard: UIView {
    
    var labelAdd: UIButton!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupTableViewFamily()
        setupConstraints()
    }
    
    func setupLabelName(){
        labelAdd = UIButton(type: .system)
        labelAdd.setTitle("Add a Student Here!", for: .normal)
        labelAdd.setImage(UIImage(systemName: "plus.message.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        labelAdd.contentHorizontalAlignment = .fill
        labelAdd.contentVerticalAlignment = .fill
        labelAdd.imageView?.contentMode = .scaleAspectFit
        labelAdd.layer.cornerRadius = 16
        labelAdd.imageView?.layer.shadowOffset = .zero
        labelAdd.imageView?.layer.shadowRadius = 0.8
        labelAdd.imageView?.layer.shadowOpacity = 0.7
        labelAdd.imageView?.clipsToBounds = true
        labelAdd.translatesAutoresizingMaskIntoConstraints = false
        labelAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAdd)
    }
    
    func setupTableViewFamily(){
        tableView = UITableView()
        tableView.register(ParentDashboardTableViewCell.self, forCellReuseIdentifier: Configs.tableViewStudentsID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelAdd.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelAdd.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: labelAdd.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
