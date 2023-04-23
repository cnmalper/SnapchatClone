//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    // Elements
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButton(_ sender: Any) {
        if usernameOrEmailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameOrEmailTextField.text!, password: passwordTextField.text!) {(result, error) in
                if error != nil {
                    Common.showAlert(errorTitle: "Error!", errorMessage: error?.localizedDescription ?? "Error!", vc: self)
                } else {
                    self.performSegue(withIdentifier: "toTabbarVC", sender: nil)
                }
            }
        } else {
            Common.showAlert(errorTitle: "Error!", errorMessage: "Please type your username/email and password.", vc: self )
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
}

