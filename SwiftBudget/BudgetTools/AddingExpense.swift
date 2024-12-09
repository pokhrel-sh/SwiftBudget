import UIKit

class AddingExpense: UIView {

    var expenseTitle: UILabel!
    var addExpenseLabel: UILabel!
    var expenseTextField: UITextField!
    var expenseName: UILabel!
    var expenseNameTextField: UITextField!
    var expenseDescription: UILabel!
    var expenseDescriptionTextField: UITextField!
    var addExpenseButton: UIButton!
    var cameraButton: UIButton! // New camera button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupExpenseTitle()
        setupExpenseLabel()
        setupExpenseTextField()
        setupExpenseName()
        setupExpenseNameTextField()
        setupExpenseDescription()
        setupExpenseDescriptionTextField()
        setupAddExpenseButton()
        setupCameraButton() // Setting up the camera button
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupExpenseTitle() {
        expenseTitle = UILabel()
        expenseTitle.text = "Expense Tracker"
        expenseTitle.textAlignment = .center
        expenseTitle.font = UIFont.boldSystemFont(ofSize: 24)
        expenseTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseTitle)
    }
    
    func setupExpenseLabel() {
        addExpenseLabel = UILabel()
        addExpenseLabel.text = "How much is the expense?"
        addExpenseLabel.font = UIFont.systemFont(ofSize: 18)
        addExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addExpenseLabel)
    }
    
    func setupExpenseTextField() {
        expenseTextField = UITextField()
        expenseTextField.placeholder = "Enter Expense Price"
        expenseTextField.borderStyle = .roundedRect
        expenseTextField.keyboardType = .numberPad
        expenseTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseTextField)
    }
    
    func setupExpenseName() {
        expenseName = UILabel()
        expenseName.text = "What is this expense for?"
        expenseName.font = UIFont.systemFont(ofSize: 18)
        expenseName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseName)
    }
    
    func setupExpenseNameTextField() {
        expenseNameTextField = UITextField()
        expenseNameTextField.placeholder = "Expense Name"
        expenseNameTextField.borderStyle = .roundedRect
        expenseNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseNameTextField)
    }
    
    func setupExpenseDescription() {
        expenseDescription = UILabel()
        expenseDescription.text = "Elaborate on the expense"
        expenseDescription.font = UIFont.systemFont(ofSize: 16)
        expenseDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseDescription)
    }
    
    func setupExpenseDescriptionTextField() {
        expenseDescriptionTextField = UITextField()
        expenseDescriptionTextField.placeholder = "Enter Description"
        expenseDescriptionTextField.borderStyle = .roundedRect
        expenseDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(expenseDescriptionTextField)
    }
    
    func setupAddExpenseButton() {
        addExpenseButton = UIButton(type: .system)
        addExpenseButton.setTitle("Add Expense", for: .normal)
        addExpenseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addExpenseButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addExpenseButton)
    }
    
    func setupCameraButton() {
        cameraButton = UIButton(type: .system)
        cameraButton.setTitle("Take Photo", for: .normal)
        cameraButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        cameraButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        cameraButton.contentHorizontalAlignment = .center
        cameraButton.contentVerticalAlignment = .center
        cameraButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cameraButton)
        
        // Add tap action to the camera button
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    @objc func cameraButtonTapped() {
        // Placeholder for camera functionality
        print("Camera button tapped")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Income Title
            expenseTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            expenseTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Add Income Label
            addExpenseLabel.topAnchor.constraint(equalTo: expenseTitle.bottomAnchor, constant: 20),
            addExpenseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income TextField
            expenseTextField.topAnchor.constraint(equalTo: addExpenseLabel.bottomAnchor, constant: 10),
            expenseTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Name Label
            expenseName.topAnchor.constraint(equalTo: expenseTextField.bottomAnchor, constant: 20),
            expenseName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income Name TextField
            expenseNameTextField.topAnchor.constraint(equalTo: expenseName.bottomAnchor, constant: 10),
            expenseNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Description Label
            expenseDescription.topAnchor.constraint(equalTo: expenseNameTextField.bottomAnchor, constant: 20),
            expenseDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income Description TextField
            expenseDescriptionTextField.topAnchor.constraint(equalTo: expenseDescription.bottomAnchor, constant: 10),
            expenseDescriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            expenseDescriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            expenseDescriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cameraButton.topAnchor.constraint(equalTo: expenseDescriptionTextField.bottomAnchor, constant: 20),
            cameraButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Add Income Button
            addExpenseButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 30),
            addExpenseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
