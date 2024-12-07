//
//  AddingExpenseViewController.swift
//  SwiftBudget
//
//  Created by Atif Agboatwala on 12/7/24.
//

import UIKit

class AddingExpenseViewController: UIViewController {
    
    let addingExpensePage = AddingExpense()
    
    override func loadView() {
        view = addingExpensePage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Adding Expense"
    }
    

}
