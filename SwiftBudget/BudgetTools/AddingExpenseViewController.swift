import UIKit
import PhotosUI
import Firebase
import FirebaseAuth

import FirebaseStorage

class AddingExpenseViewController: UIViewController {
    
    let addingExpensePage = AddingExpense()
    var selectedChild: String? // Track the selected child
    let storage = Storage.storage()
    var pickedImage:UIImage?
        
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
        addingExpensePage.saveButton.addTarget(self, action: #selector(handleSaveExpense), for: .touchUpInside)
        addingExpensePage.buttonTakePhoto.menu = getMenuImagePicker()
        addingExpensePage.buttonTakePhoto.showsMenuAsPrimaryAction = true
    }
    
    func getMenuImagePicker() -> UIMenu{
            let menuItems = [
                UIAction(title: "Camera",handler: {(_) in
                    self.pickUsingCamera()
                }),
                UIAction(title: "Gallery",handler: {(_) in
                    self.pickPhotoFromGallery()
                })
            ]
            
            return UIMenu(title: "Select source", children: menuItems)
        }
        
        //MARK: take Photo using Camera...
        func pickUsingCamera(){
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.allowsEditing = true
            cameraController.delegate = self
            present(cameraController, animated: true)
        }
        
        //MARK: pick Photo using Gallery...
        func pickPhotoFromGallery(){
            //MARK: Photo from Gallery...
            var configuration = PHPickerConfiguration()
            configuration.filter = PHPickerFilter.any(of: [.images])
            configuration.selectionLimit = 1
            
            let photoPicker = PHPickerViewController(configuration: configuration)
            
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
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
    
    @objc func saveExpense(photoURL: URL?) {
        guard let name = addingExpensePage.nameTextField.text, !name.isEmpty,
              let priceText = addingExpensePage.priceTextField.text, let price = Double(priceText),
              let date = addingExpensePage.dateTextField.text, !date.isEmpty,
              let addedBy = addingExpensePage.addedByTextField.text, !addedBy.isEmpty else {
            showError("Please fill all fields correctly.")
            return
        }
        
        let forUser = selectedChild ?? addedBy
        let imageString = photoURL?.absoluteString ?? "" // Convert URL to String
        
        let expense = Expense(
            name: name,
            price: price,
            date: Date(),
            image: imageString,
            addedBy: addedBy,
            for_user: forUser
        )
        
        saveToFirebase(expense: expense)
    }


    
    func saveToFirebase(expense: Expense) {
        let db = Firestore.firestore()
        
        db.collection("expenses").addDocument(data: [
            "name": expense.name,
            "price": expense.price,
            "date": expense.date, // Format date to string if Firestore requires
            "image": expense.image,
            "addedBy": expense.addedBy,
            "for_user": expense.for_user
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
                self.showError("Error saving expense: \(error.localizedDescription)")
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

extension AddingExpenseViewController{
    @objc func handleSaveExpense() {
        uploadProfilePhotoToStorage()
    }
    
    func uploadProfilePhotoToStorage() {
        guard let image = pickedImage, let jpegData = image.jpegData(compressionQuality: 0.8) else {
            // If no image, proceed to save the expense without an image
            saveExpense(photoURL: nil)
            return
        }
        
        let storageRef = storage.reference()
        let imagesRepo = storageRef.child("imagesUsers")
        let imageRef = imagesRepo.child("\(UUID().uuidString).jpg")
        
        // Log upload path for debugging
        print("Uploading to: \(imageRef.fullPath)")
        
        imageRef.putData(jpegData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                self.showError("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            // Get the download URL after successful upload
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error fetching image URL: \(error.localizedDescription)")
                    self.showError("Error fetching image URL: \(error.localizedDescription)")
                    return
                }
                
                // Proceed to save the expense with the image URL
                self.saveExpense(photoURL: url)
            }
        }
    }
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}

extension AddingExpenseViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.addingExpensePage.buttonTakePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    }
                )
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension AddingExpenseViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addingExpensePage.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
