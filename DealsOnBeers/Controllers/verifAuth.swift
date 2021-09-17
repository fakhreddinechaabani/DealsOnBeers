//
//  verifAuth.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/23/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import Foundation
import FirebaseAuth
class verifAuth {
    
    func verifAuth() -> Bool {
        let hasSession = (Auth.auth().currentUser != nil)
        
            if hasSession {
          
                return true
            } else {
                return false
            }
        }

}
