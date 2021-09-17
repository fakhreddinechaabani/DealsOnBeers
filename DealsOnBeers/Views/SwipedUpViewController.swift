//
//  SwipedUpViewController.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/26/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class SwipedUpViewController: UIViewController {
    struct selectedanno {
        static var anno = CustomAnno()
    }
    struct rate {
        static var rating : Double = 0.0
        
    }
  
        var handler: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var titleinfo: UILabel!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var DescV: UITextView!
    @IBOutlet var V: UIView!
    var iduser : String = ""
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initinfov()
        verif()
        
    }
    func createSpinnerView(){
        
    }
    
    func addrev(rating: Double){
        var name = Auth.auth().currentUser?.displayName
        let trimmedname = name?.components(separatedBy: " ")
        let lastname = trimmedname![1]
        let ch = lastname.substring(to: .init(encodedOffset: 1))
        name = trimmedname![0] + " " + String(ch)
       
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let hourString = formatter.string(from: Date())
       let sto = Storage.storage()
       let storageref = sto.reference()
        let imagesref = storageref.child(selectedanno.anno.id).child("images/profile\(self.iduser).png")
        
        _ = imagesref.putData((MainViewController.selectedann.imageprofile?.pngData())!, metadata: nil){ (metadata, error) in
            guard let metadata = metadata else {
                return
            }
            _ = metadata.size
            imagesref.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                
                let values = ["userID": self.iduser,"rating": String(rating),"name":name ,"pictureUrl": downloadURL.absoluteString,"time": hourString, "placeID": selectedanno.anno.id]
                Firestore.firestore().collection("Reviews").document().setData(values as [String : Any]){ err in
                    
                    if err != nil {
                        print("error")
                    } else {
                        
                    }
                    
                }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        handler = Auth.auth().addStateDidChangeListener({ (auth, user) in
            let child = SpinnerViewController()
            self.addChild(child)
            child.view.frame = self.view.frame
            self.view.addSubview(child.view)
            child.didMove(toParent: self)
            self.verif()

            if Auth.auth().currentUser != nil {
                if let data = try? Data(contentsOf: (Auth.auth().currentUser?.photoURL)!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            MainViewController.selectedann.imageprofile = image
                            child.willMove(toParent: nil)
                            child.view.removeFromSuperview()
                            child.removeFromParent()
                        }
                    }
                }
                
            }else {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        })
        
        }
  
    func verif(){
       
        
       
           
       
            
        
            self.cosmosView.rating = 0.0
        var revifexist = ""
        if Auth.auth().currentUser != nil {
            let iduser = Auth.auth().currentUser?.uid
        let current = Auth.auth().currentUser
        var verif : Bool = false
        Firestore.firestore().collection("Reviews").getDocuments() { (document, error) in
            if error != nil {
                print("error getting reviews")
            }
            else {
                for doc in document!.documents {
                    let user = doc.get("userID") as! String
                    let rating = doc.get("rating") as! String
                    let place = doc.get("placeID") as! String
                    if user == self.iduser && place == selectedanno.anno.id  {
                        revifexist = rating
                        verif = true
                        continue
                    }else {
                        
                            verif = false
                            
                            
                        }
                    }
                    
                    
                }
                if verif == true {
                    self.cosmosView.rating = Double(revifexist)!
                    self.cosmosView.isUserInteractionEnabled = false
                }else {
                    self.cosmosView.didTouchCosmos = { rating in
                        rate.rating = rating
                        self.addrev(rating: rating)
                        let st = UIStoryboard(name: "st", bundle: nil)
                        
                        let vc = st.instantiateViewController(withIdentifier: "FeedbackViewController") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                }
            }
        
            }}
        else {
           
            self.cosmosView.didTouchCosmos = { rating in
                 self.cosmosView.rating = 0.0
             
                let st = UIStoryboard(name: "st", bundle: nil)
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(vc!, animated: true, completion: nil)
            }
        }
      
       
    }
   

    
    
    func descinit(S: String){
        DescV.text = S}
    
    func initinfov(){
        viewInfo.frame = CGRect(x:10,y:30,width:view.bounds.width-20,height:view.bounds.height/3)
        viewInfo.layer.borderColor = UIColor.black.cgColor
        viewInfo.layer.borderWidth = 2
        view.addSubview(viewInfo)
        DescV.frame = CGRect(x: 10, y: 25,width: viewInfo.bounds.width - 20, height: view.bounds.height/3-40)
        viewInfo.addSubview(DescV)
        titleinfo.frame = CGRect(x: (viewInfo.bounds.width/2 + 10) - 75 , y: 10, width: 150, height: 40)
        viewInfo.addSubview(titleinfo)
        view.insertSubview(titleinfo, aboveSubview: viewInfo)
    }
    



}
