//
//  FeedbackViewController.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/28/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseAuth

class FeedbackViewController: UIViewController {
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var cosmos: CosmosView!
    @IBOutlet weak var labelname: UILabel!
    var userid : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        cosmos.isUserInteractionEnabled = false
        initframe()
        
}
    override func viewWillAppear(_ animated: Bool) {
        profileIMG.image = MainViewController.selectedann.imageprofile
        labelname.text = Auth.auth().currentUser?.displayName
        userid = (Auth.auth().currentUser?.uid)!
        let number : Double = SwipedUpViewController.rate.rating
        cosmos.rating = number
    }
    func initframe() {
        profileIMG.clipsToBounds = false
        profileIMG.layer.cornerRadius = profileIMG.bounds.height/2
    }
    
    @IBAction func dissmissbtn(_ sender: Any) {
self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sharebtn(_ sender: Any) {
    }
    

}
