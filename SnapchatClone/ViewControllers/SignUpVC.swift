//
//  SecondViewController.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpVC: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var socialImage: UIImageView!
    @IBOutlet weak var signUpEmailTaxtField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        if signUpEmailTaxtField.text != "" && signUpPasswordTextField.text != "" && usernameTextField.text != "" {
            
            Auth.auth().createUser(withEmail: signUpEmailTaxtField.text!, password: signUpPasswordTextField.text!) { (auth, error) in
                if error != nil {
                    Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
                } else {
                    let firestore = Firestore.firestore()
                    let userDict = ["email" : self.signUpEmailTaxtField.text!,"username": self.usernameTextField.text!] as [String : Any]
                    firestore.collection("UserInfo").addDocument(data: userDict) {(error) in
                        if error != nil {
                            
                        }
                    }
                    self.performSegue(withIdentifier: "toTabbarVC", sender: nil)
                }
            }
            
            
        } else {
            Common.showAlert(errorTitle: "Error!", errorMessage: "Please type your username/email and password.", vc: self)
        }
    }
    
}
