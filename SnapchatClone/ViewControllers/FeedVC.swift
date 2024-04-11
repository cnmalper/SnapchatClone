//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    var timeLeft : Int?
    
    let fireStoreDatabase = Firestore.firestore()
    let currentUserMail = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userEmailLabel.text = "Signed in as \(currentUserMail ?? "Unknown user")"
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        getSnapsFromFirebase()
        getUserInfo()
    
    }
    
    func getSnapsFromFirebase() {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "ERROR", vc: self)
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String]{
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete()
                                        } else {
                                            let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                            self.snapArray.append(snap)
                                        }
                                        self.timeLeft = 24 - difference
                                    }
                                }
                            }
                        }
                    }
                    self.feedTableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo() {
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
        
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "snapCell", for: indexPath) as! FeedCell
        cell.cellsnapImage.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        cell.cellUserEmailLabel.text = self.snapArray[indexPath.row].username // snapArray[indexPath.row] bu bir snap object verir.
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            if let destinationVC = segue.destination as? SnapVC {
                destinationVC.selectedSnap = self.chosenSnap
                destinationVC.selectedTime = self.timeLeft
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
}
