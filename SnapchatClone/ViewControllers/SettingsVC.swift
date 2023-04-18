//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 17.04.2023.
//

import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {

    @IBOutlet weak var signUpSocialImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
        } catch {
            Common.showAlert(errorTitle: "Error!", errorMessage: "Error!", vc: self)
        }
    }
}
