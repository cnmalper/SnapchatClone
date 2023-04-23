//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Alper Canımoğlu on 22.04.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
    
    
}
