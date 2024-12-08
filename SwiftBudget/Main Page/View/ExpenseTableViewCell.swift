//
//  ExpenseTableViewCell.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/3/24.
//

import UIKit
class ExpenseTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelPrice: UILabel!
    var labelDate: UILabel!
    var labelAddedBy: UILabel!
    var expenseImageView: UIImageView!  // Added image view
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelPrice()
        setupLabelDate()
        setupLabelAddedBy()
        setupExpenseImageView()  // Setup image view
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }

    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }

    func setupLabelPrice() {
        labelPrice = UILabel()
        labelPrice.font = UIFont.boldSystemFont(ofSize: 16)
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrice)
    }

    func setupLabelDate() {
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }

    func setupLabelAddedBy() {
        labelAddedBy = UILabel()
        labelAddedBy.font = UIFont.italicSystemFont(ofSize: 14)
        labelAddedBy.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAddedBy)
    }

    func setupExpenseImageView() {
        expenseImageView = UIImageView()
        expenseImageView.contentMode = .scaleAspectFit
        expenseImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(expenseImageView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            
            labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelPrice.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            labelDate.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 8),
            labelDate.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            labelAddedBy.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 8),
            labelAddedBy.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            expenseImageView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            expenseImageView.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            expenseImageView.widthAnchor.constraint(equalToConstant: 50),
            expenseImageView.heightAnchor.constraint(equalToConstant: 50),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
