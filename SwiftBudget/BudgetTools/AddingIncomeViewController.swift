import UIKit
import Firebase
import FirebaseAuth
import PhotosUI
import FirebaseStorage

class AddingIncomeViewController: UIViewController {
    
    let addIncomePage = AddingIncome()
    var currentUser: FirebaseAuth.User?
    var SelectedUser: String?
    let database = Firestore.firestore()
    let storage = Storage.storage()
    var pickedImage:UIImage?
    
    override func loadView() {
        view = addIncomePage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Adding Income Page"
        
        setupCurrentUser()
        
        addIncomePage.cameraButton.menu = getMenuImagePicker()
        addIncomePage.cameraButton.showsMenuAsPrimaryAction = true
        addIncomePage.addIncomeButton.addTarget(self, action: #selector(handleSaveIncome), for: .touchUpInside)
    }
    
    func setupCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
        }
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
    
    @objc func saveIncome(photoURL: URL?) {
        guard let name = addIncomePage.incomeNameTextField.text, !name.isEmpty,
              let desc = addIncomePage.incomeDescriptionTextField.text, !desc.isEmpty,
              let incomeAmount = addIncomePage.incomeTextField.text,
              let income = Double(incomeAmount), !incomeAmount.isEmpty,
              let addedBy = self.currentUser?.email else {
            
            showError("Please fill all fields correctly.")
            return
        }
        
        let forUser = SelectedUser ?? addedBy
        let imageString = photoURL?.absoluteString ?? ""
        
        let newIncome = Transaction(type: "income", name: name, amount: income, desc: desc, date: Date(), image: imageString, addedBy: addedBy, for_user: forUser)
        
        saveToFirebase(income: newIncome)
    }
    
    func saveToFirebase(income: Transaction) {

        database.collection("transactions").addDocument(data: [
            "type": income.type,
            "name": income.name,
            "amount": income.amount,
            "desc": income.desc,
            "date": income.date,
            "image": income.image,
            "addedBy": income.addedBy,
            "for_user": income.for_user
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
extension AddingIncomeViewController{
    @objc func handleSaveIncome() {
        uploadProfilePhotoToStorage()
    }
    
    func uploadProfilePhotoToStorage() {
        guard let image = pickedImage, let jpegData = image.jpegData(compressionQuality: 0.8) else {
            // If no image, proceed to save the expense without an image
            saveIncome(photoURL: nil)
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
                self.saveIncome(photoURL: url)
            }
        }
    }
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
}

extension AddingIncomeViewController:PHPickerViewControllerDelegate{
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
                                self.addIncomePage.cameraButton.setImage(
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
extension AddingIncomeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addIncomePage.cameraButton.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            print("No Image Loaded")
        }
    }
}

