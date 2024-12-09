import UIKit
import Firebase
import FirebaseAuth

class AddingExpenseViewController: UIViewController {
    
    let addingExpensePage = AddingExpense()
    var currentUser:FirebaseAuth.User?
    var SelectedUser:String?
    let database = Firestore.firestore()
        
    override func loadView() {
        view = addingExpensePage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Adding Expense"
        
        setupCurrentUser()
      
        // Add actions
        addingExpensePage.saveButton.addTarget(self, action: #selector(saveExpense), for: .touchUpInside)
    }
    
    func setupCurrentUser() {
        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }
        self.currentUser = user
        fetchUserRole(email: (self.currentUser?.email)!)
    }
    
    func fetchUserRole(email: String) {

        database.collection("users2").document((self.currentUser?.uid)!).getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                let role = data?["role"] as? String ?? ""
                
                print("FetchUserRole: \(role)") // Check what role is fetched
                
                if role == "Kid" {
                    self.SelectedUser = email
                    print("Role is kid and email is: \(email)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    @objc func saveExpense() {
        guard let name = addingExpensePage.nameTextField.text, !name.isEmpty,
              let priceText = addingExpensePage.priceTextField.text, let price = Double(priceText), !priceText.isEmpty,
              let addedBy = self.currentUser?.email, let selected = self.SelectedUser else {
            showError("Please fill all fields correctly.")
            return
        }
        
        let expense = Expense(name: name, price: price, date: Date(), image: "", addedBy: addedBy, for_user: selected)
        
        saveToFirebase(expense: expense)
    }
    
    func saveToFirebase(expense: Expense) {
        
        database.collection("expenses").addDocument(data: [
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
        
        db.collection("transactions").addDocument(data: [
            "name": expense.name,
            "amount": expense.price,
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
