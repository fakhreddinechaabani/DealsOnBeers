//
//  LoginViewController.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/30/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate, GIDSignInUIDelegate  {
    @IBOutlet weak var GoogleBtnV: GIDSignInButton!
    @IBOutlet weak var FacebookBtnV: FBSDKLoginButton!
    
    
    @IBOutlet weak var MainV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       FacebookBtnV.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        
initv()
    }
    
    
    func initv(){
 
    }
  
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if FBSDKAccessToken.current() != nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    return
                    
                }else {
                    
                   
                    
                    if let data = try? Data(contentsOf: (Auth.auth().currentUser?.photoURL)!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                MainViewController.selectedann.imageprofile = image
                            }
                        }
                    }
                        
                     
                    self.dismiss(animated: true, completion: nil)
                   
                    
                }
            }
        }
    }
   
    

   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != MainV {
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
