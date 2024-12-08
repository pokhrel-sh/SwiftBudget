import UIKit
import Firebase
import FirebaseAuth

class AddingExpenseViewController: UIViewController {
    
    let addingExpensePage = AddingExpense()
    var selectedChild: String? // Track the selected child
        
    override func loadView() {
        view = addingExpensePage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Adding Expense"
        
        setupCurrentUser()
        guard let email = Auth.auth().currentUser?.email else {
            print("No user email found")
            return
        }
        fetchUserRole()
        fetchFamilyCircle(email: email)
        
        // Add actions
        addingExpensePage.saveButton.addTarget(self, action: #selector(saveExpense), for: .touchUpInside)
    }
    
    func setupCurrentUser() {
        if let user = Auth.auth().currentUser {
            addingExpensePage.addedByTextField.text = user.email
            fetchUserRole()
        }
    }
    
    func fetchUserRole() {
        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }

        let db = Firestore.firestore()
        
        // Fetching the user document by UID (UID is now the document ID)
        db.collection("users2").document(user.uid).getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let role = data?["role"] as? String ?? ""
                
                print("FetchUserRole: \(role)") // Check what role is fetched
                
                if role == "Parent" {
                    self.fetchFamilyCircle(email: user.email!)
                    self.addingExpensePage.selectChildTextField.isHidden = false // Show the picker field
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    
    func fetchFamilyCircle(email: String) {
        print("fetchFamilyCircle called with email: \(email)")
        let db = Firestore.firestore()
        db.collection("familyCircle").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching kids: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents, let data = documents.first?.data() else {
                print("No matching documents found")
                return
            }
        }
    }
    
    @objc func saveExpense() {
        guard let name = addingExpensePage.nameTextField.text, !name.isEmpty,
              let priceText = addingExpensePage.priceTextField.text, let price = Double(priceText),
              let date = addingExpensePage.dateTextField.text, !date.isEmpty,
              let addedBy = addingExpensePage.addedByTextField.text, !addedBy.isEmpty else {
            showError("Please fill all fields correctly.")
            return
        }
        
        let forUser = selectedChild ?? addedBy // Use selected child or addedBy for `for_user`
        
        let expense = Expense(name: name, price: price, date: Date(), image: "", addedBy: addedBy, for_user: forUser)
        saveToFirebase(expense: expense)
    }
    
    func saveToFirebase(expense: Expense) {
        let db = Firestore.firestore()
        
        db.collection("expenses").addDocument(data: [
            "name": expense.name,
            "price": expense.price,
            "date": expense.date,
            "image": expense.image,
            "addedBy": expense.addedBy,
            "for_user": expense.for_user
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
