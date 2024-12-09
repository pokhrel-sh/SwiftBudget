import UIKit

class AddingIncome: UIView {
    
    var incomeTitle: UILabel!
    var addIncomeLabel: UILabel!
    var incomeTextField: UITextField!
    var incomeName: UILabel!
    var incomeNameTextField: UITextField!
    var incomeDescription: UILabel!
    var incomeDescriptionTextField: UITextField!
    var addIncomeButton: UIButton!
    var cameraButton: UIButton! // New camera button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupIncomeTitle()
        setupIncomeLabel()
        setupIncomeTextField()
        setupIncomeName()
        setupIncomeNameTextField()
        setupIncomeDescription()
        setupIncomeDescriptionTextField()
        setupAddIncomeButton()
        setupCameraButton() // Setting up the camera button
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIncomeTitle() {
        incomeTitle = UILabel()
        incomeTitle.text = "Income Tracker"
        incomeTitle.textAlignment = .center
        incomeTitle.font = UIFont.boldSystemFont(ofSize: 24)
        incomeTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeTitle)
    }
    
    func setupIncomeLabel() {
        addIncomeLabel = UILabel()
        addIncomeLabel.text = "How much do you want to add to budget?"
        addIncomeLabel.font = UIFont.systemFont(ofSize: 18)
        addIncomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addIncomeLabel)
    }
    
    func setupIncomeTextField() {
        incomeTextField = UITextField()
        incomeTextField.placeholder = "Enter Income Amount"
        incomeTextField.borderStyle = .roundedRect
        incomeTextField.keyboardType = .numberPad
        incomeTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeTextField)
    }
    
    func setupIncomeName() {
        incomeName = UILabel()
        incomeName.text = "Where is this money coming from?"
        incomeName.font = UIFont.systemFont(ofSize: 18)
        incomeName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeName)
    }
    
    func setupIncomeNameTextField() {
        incomeNameTextField = UITextField()
        incomeNameTextField.placeholder = "Income Name"
        incomeNameTextField.borderStyle = .roundedRect
        incomeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeNameTextField)
    }
    
    func setupIncomeDescription() {
        incomeDescription = UILabel()
        incomeDescription.text = "Elaborate the income"
        incomeDescription.font = UIFont.systemFont(ofSize: 16)
        incomeDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeDescription)
    }
    
    func setupIncomeDescriptionTextField() {
        incomeDescriptionTextField = UITextField()
        incomeDescriptionTextField.placeholder = "Enter Description"
        incomeDescriptionTextField.borderStyle = .roundedRect
        incomeDescriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(incomeDescriptionTextField)
    }
    
    func setupAddIncomeButton() {
        addIncomeButton = UIButton(type: .system)
        addIncomeButton.setTitle("Add Income", for: .normal)
        addIncomeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addIncomeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addIncomeButton)
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
            incomeTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            incomeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Add Income Label
            addIncomeLabel.topAnchor.constraint(equalTo: incomeTitle.bottomAnchor, constant: 20),
            addIncomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income TextField
            incomeTextField.topAnchor.constraint(equalTo: addIncomeLabel.bottomAnchor, constant: 10),
            incomeTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            incomeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            incomeTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Name Label
            incomeName.topAnchor.constraint(equalTo: incomeTextField.bottomAnchor, constant: 20),
            incomeName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income Name TextField
            incomeNameTextField.topAnchor.constraint(equalTo: incomeName.bottomAnchor, constant: 10),
            incomeNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            incomeNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            incomeNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Income Description Label
            incomeDescription.topAnchor.constraint(equalTo: incomeNameTextField.bottomAnchor, constant: 20),
            incomeDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            // Income Description TextField
            incomeDescriptionTextField.topAnchor.constraint(equalTo: incomeDescription.bottomAnchor, constant: 10),
            incomeDescriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            incomeDescriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            incomeDescriptionTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cameraButton.topAnchor.constraint(equalTo: incomeDescriptionTextField.bottomAnchor, constant: 20),
            cameraButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Add Income Button
            addIncomeButton.topAnchor.constraint(equalTo: cameraButton.bottomAnchor, constant: 30),
            addIncomeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
