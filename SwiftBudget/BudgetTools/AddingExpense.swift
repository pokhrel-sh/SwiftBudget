import UIKit

class AddingExpense: UIView {
    
    
    var nameTextField: UITextField!
    var priceTextField: UITextField!
    var dateTextField: UITextField!
    var addedByTextField: UITextField!
    var selectChildTextField: UITextField!
    var saveButton: UIButton!
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNameField()
        setupPriceField()
        setupDateField()
        setupAddedByField()
        setupSelectChildField()
        setupSaveButton()
        
        initConstraints()
    }
    
    func setupNameField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Expense Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }
    
    func setupPriceField() {
        priceTextField = UITextField()
        priceTextField.placeholder = "Price"
        priceTextField.keyboardType = .decimalPad
        priceTextField.borderStyle = .roundedRect
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceTextField)
    }
    
    func setupDateField() {
        dateTextField = UITextField()
        dateTextField.placeholder = "Date (MM/DD/YYYY)"
        dateTextField.borderStyle = .roundedRect
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateTextField)
    }
    
    func setupAddedByField() {
        addedByTextField = UITextField()
        addedByTextField.placeholder = "Added By"
        addedByTextField.isEnabled = false
        addedByTextField.borderStyle = .roundedRect
        addedByTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addedByTextField)
    }
    
    func setupSelectChildField() {
        selectChildTextField = UITextField()
        selectChildTextField.placeholder = "Select Child"
        selectChildTextField.borderStyle = .roundedRect
        selectChildTextField.isHidden = true
        selectChildTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectChildTextField)
    }
    
    func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save Expense", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 5
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveButton)
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initConstraints() {
        
        // Layout
        NSLayoutConstraint.activate([
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Price TextField
            priceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            priceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            priceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Date TextField
            dateTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 20),
            dateTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Added By TextField
            addedByTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20),
            addedByTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addedByTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Select Child TextField
            selectChildTextField.topAnchor.constraint(equalTo: addedByTextField.bottomAnchor, constant: 20),
            selectChildTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            selectChildTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Save Button
            saveButton.topAnchor.constraint(equalTo: selectChildTextField.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

