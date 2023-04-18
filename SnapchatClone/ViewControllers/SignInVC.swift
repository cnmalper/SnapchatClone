//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit

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
        if let tabbarVC = storyboard?.instantiateViewController(withIdentifier: "tabbarVC") {
            navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "signUpVC") {
            navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
}

