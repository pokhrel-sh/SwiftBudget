//
//  File.swift
//  SwiftBudget
//
//  Created by Kidus Yohannes on 12/8/24.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

extension ParentDashboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewStudentsID, for: indexPath) as! ParentDashboardTableViewCell
        cell.labelName.text = familyList[indexPath.row].name
        cell.labelEmail.text = familyList[indexPath.row].email
        cell.labelBalance.text = "Balance: \(familyList[indexPath.row].balance ?? 0.0)"
        
        //MARK: crating an accessory button...
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        //MARK: setting an icon from sf symbols...
        buttonOptions.setImage(UIImage(systemName: "dollarsign.bank.building.fill"), for: .normal)
        
        //MARK: setting up menu for button options click...
        buttonOptions.menu = UIMenu(title: "Add?",
                                    children: [
                                        UIAction(title: "Allowance",handler: {(_) in
                                            self.allowanceSelected(student: indexPath.row)
                                        }),
                                        UIAction(title: "Expense",handler: {(_) in
                                            self.expenseSelectedFor(student: indexPath.row)
                                        })
                                    ])
        //MARK: setting the button as an accessory of the cell...
        cell.accessoryView = buttonOptions
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDash = DashboardViewController()
        studentDash.overrideEmail = familyList[indexPath.row].email
        print(familyList[indexPath.row])
        self.navigationController?.pushViewController(studentDash, animated: true)
    }
    
    func allowanceSelected(student: Int){
        let income = AddingIncomeViewController()
        income.SelectedUser = familyList[student].email
        print(familyList[student])
        self.navigationController?.pushViewController(income, animated: true)
    }

    func expenseSelectedFor(student: Int){
        let expense = AddingExpenseViewController()
        expense.SelectedUser = familyList[student].email
        self.navigationController?.pushViewController(expense, animated: true)
    }
}

extension ParentDashboardViewController{
    func setupRightBarButton(isLoggedin: Bool){
        if isLoggedin{
            //MARK: user is logged in...
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
            
        }
    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    print("User Logged Out")
                    self.setupRightBarButton(isLoggedin: false)
                    self.navigationController?.popViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
