// 
// Initial landing page
//
//
//  ViewController.swift
//  SwiftBudget
//
//  Created by Shishir Pokhrel on 12/2/24.
//

import UIKit

class ViewController: UIViewController {

    var titleLabel: UILabel!
    var familyLabel: UILabel!
    var independantLabel: UILabel!
    var parentButton: UIButton!
    var dependantButton: UIButton!
    var studentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: Initializing the UI elements
        setupLabelAppName()
        setupFamilyLabel()
        setupParentsButton()
        setupDependantButton()
        setupIndependantLabel()
        setupStudentButton()
        
        // MARK: Initializing the constraints
        initConstraints()
    }
    
    func setupLabelAppName() {
        titleLabel = UILabel()
        titleLabel.text = "SwiftBudget"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }

    func setupFamilyLabel() {
        familyLabel = UILabel()
        familyLabel.text = "Family"
        familyLabel.font = UIFont.systemFont(ofSize: 18)
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(familyLabel)
    }
    
    func setupIndependantLabel() {
        independantLabel = UILabel()
        independantLabel.text = "Independant"
        independantLabel.font = UIFont.systemFont(ofSize: 18)
        independantLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(independantLabel)
    }
    
    func setupParentsButton() {
        parentButton = UIButton(type: .system)
        parentButton.setTitle("Parents", for: .normal)
        parentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(parentButton)
    }
    
    func setupDependantButton() {
        dependantButton = UIButton(type: .system)
        dependantButton.setTitle("Dependants", for: .normal)
        dependantButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dependantButton)
    }
    
    func setupStudentButton() {
        studentButton = UIButton(type: .system)
        studentButton.setTitle("Student", for: .normal)
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(studentButton)
    }
    
    func initConstraints() {
        let sizeableGap: CGFloat = 40
        
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Family Label Constraints
            familyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            familyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Parent Button Constraints
            parentButton.topAnchor.constraint(equalTo: familyLabel.bottomAnchor, constant: 16),
            parentButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            
            // Dependant Button Constraints
            dependantButton.topAnchor.constraint(equalTo: familyLabel.bottomAnchor, constant: 16),
            dependantButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            
            // Gap Between Sections
            independantLabel.topAnchor.constraint(equalTo: parentButton.bottomAnchor, constant: sizeableGap),
            independantLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Student Button Constraints
            studentButton.topAnchor.constraint(equalTo: independantLabel.bottomAnchor, constant: 16),
            studentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
