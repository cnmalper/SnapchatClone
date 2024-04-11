//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var uploadUserMailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uploadUserMailLabel.text = "Signed in as \(uploadCurrentUserMail ?? "Unknown user")"
        
    }
    
    let uploadCurrentUserMail = Auth.auth().currentUser?.email

    @IBAction func selectImageUploadButton(_ sender: Any) {
        
        // MARK - ImagePicker
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        // MARK - Storage
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let imageData = uploadImageView.image?.jpegData(compressionQuality: 0.5){
            let uuidString = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuidString).jpg")
            imageReference.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil{
                    Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Your image could not uploaded to storage.", vc: self)
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                           let imageUrl = url?.absoluteString
                            
                            // MARK - Firestore
                            
                            let firestore = Firestore.firestore()
                            
                            firestore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { (snapshot, error) in
                                
                                if error != nil {
                                    Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
                                } else {
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents {
                                            
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDict = ["imageUrlArray" : imageUrlArray] as [String : Any]
                                                
                                                firestore.collection("Snaps").document(documentId).setData(additionalDict, merge: true) { (error) in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "logo")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        // Daha once veri kaydedilmemis
                                        
                                        let snapDict = ["imageUrlArray" : [imageUrl!], "snapOwner" : UserSingleton.sharedUserInfo.username,"date":FieldValue.serverTimestamp()] as [String : Any]
                                        firestore.collection("Snaps").addDocument(data: snapDict) { (error) in
                                            if error != nil {
                                                Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
                                            } else {
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(named: "logo")
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    

}
