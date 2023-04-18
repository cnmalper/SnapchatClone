//
//  SecondViewController.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var socialImage: UIImageView!
    @IBOutlet weak var signUpUsernameOrEmailTaxtField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        if signUpUsernameOrEmailTaxtField.text != "" && signUpPasswordTextField.text != "" {
            
            Auth.auth().createUser(withEmail: signUpUsernameOrEmailTaxtField.text!, password: signUpPasswordTextField.text!) { (auth, error) in
                if error != nil {
                    Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
                } else {
                    self.performSegue(withIdentifier: "toTabbarVC", sender: nil)
                }
            }
            
            
        } else {
            Common.showAlert(errorTitle: "Error!", errorMessage: "Please type your username/email and password.", vc: self)
        }
    }
    
}
