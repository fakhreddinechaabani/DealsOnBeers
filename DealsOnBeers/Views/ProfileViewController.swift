//
//  ProfileViewController.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/26/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import GoogleSignIn


class ProfileViewController: UIViewController {
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var picV: UIView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var profileImgV: UIImageView!
    @IBOutlet weak var Signoutbtn: UIButton!
    @IBOutlet weak var labelName: UILabel!
    let child = SpinnerViewController()
    var handler: AuthStateDidChangeListenerHandle?
    var activityindic : UIActivityIndicatorView = UIActivityIndicatorView()
    let lightpink = UIColor(red: 54.0/255.0, green: 138.0/255.0, blue: 156.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      initsignoutbtn()
      
            initframe()
        self.addChild(child)
        child.view.frame = self.view.frame
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
             self.initprofile()
        }
       
               }
           
        

    
  
    func loadImage(){
        if let userid = Auth.auth().currentUser {
            if   let St1 = userid.photoURL?.absoluteString {
           let St2 = St1 + "" + "?height=150"
        
        print(St2)
            let url = URL(string: St2)
       
        if let data = try? Data(contentsOf: (url)! as URL) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImgV.image = image
                    
                    self.child.willMove(toParent: nil)
                    self.child.view.removeFromSuperview()
                    self.child.removeFromParent()
                }
            }
                }
        }
        }
    }
    func initframe(){
         topview.backgroundColor = lightpink
        arrow.image?.withRenderingMode(.alwaysTemplate)
        self.profileImgV.layer.borderColor = UIColor.black.cgColor
        self.profileImgV.layer.borderWidth = 2
        self.profileImgV.layer.cornerRadius = 75
        self.profileImgV.clipsToBounds = true
        self.profileImgV.layer.masksToBounds = true
        picV.layer.shadowOpacity = 0.8
        self.picV.layer.shadowRadius = 10
        self.picV.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.picV.layer.shadowColor = UIColor.black.cgColor

    }
    func initprofile(){
       
        self.labelName.text = Auth.auth().currentUser?.displayName
       loadImage()
        
    }
    @IBAction func returnbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnsignout(_ sender: Any) {
        try? Auth.auth().signOut()
        try? GIDSignIn.sharedInstance()?.signOut()
        MainViewController.selectedann.imageprofile = UIImage(named: "profile")
         dismiss(animated: true, completion: nil)
      
        
    }
    
    func initsignoutbtn(){
        
        self.Signoutbtn.layer.cornerRadius = self.Signoutbtn.bounds.height/2
        self.Signoutbtn.layer.borderColor = UIColor.black.cgColor
        self.Signoutbtn.layer.borderWidth = 2
        self.Signoutbtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.Signoutbtn.layer.shadowRadius = 8
        self.Signoutbtn.layer.shadowColor = UIColor.black.cgColor
        self.Signoutbtn.layer.shadowOpacity = 0.5
    }

}
