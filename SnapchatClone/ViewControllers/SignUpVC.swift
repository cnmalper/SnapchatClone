//
//  SecondViewController.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit

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
            
        }
    }
    
}
