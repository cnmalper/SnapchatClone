//
//  Common.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 18.04.2023.
//

import Foundation
import UIKit

class Common : NSObject {
    
    class func showAlert(errorTitle: String, errorMessage: String, vc: UIViewController){
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: errorTitle, style: UIAlertAction.Style.default))
        vc.present(alert, animated: true)
    }
    
}

