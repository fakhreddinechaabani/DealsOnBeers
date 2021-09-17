//
//  SearchbarViewController.swift
//  DealsOnBeers
//
//  Created by fakhreddine chaabani on 3/3/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit

class SearchbarViewController: UIViewController {
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        self.textfield.becomeFirstResponder()
        super.viewDidLoad()
        initframe()
searchviewinit()
    }
    
    @IBAction func backbtn(_ sender: UIButton) {
   dismiss(animated: false, completion: nil)
    }
    func initframe () {
        
        let maskLayer = CAGradientLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.colors = [ UIColor.clear.cgColor, UIColor.black.cgColor]
        maskLayer.locations = [0.0, 0.07]
        maskLayer.shadowRadius = 0.0
        //  maskLayer.shadowPath = CGPath(roundedRect: self.view.bounds.insetBy(dx: 0, dy: 1), cornerWidth: 1, cornerHeight: 1, transform: nil)
        maskLayer.shadowOpacity = 8
       // maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        self.view.layer.mask = maskLayer
    }
    func searchviewinit(){
        searchview.layer.cornerRadius = 20
        searchview.layer.masksToBounds = false
        searchview.layer.borderColor = UIColor.black.cgColor
        searchview.layer.shadowColor = UIColor.black.cgColor
        searchview.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        searchview.layer.shadowRadius = 1.0
        searchview.layer.shadowOpacity = 0.5
        searchview.layer.borderColor = UIColor.black.cgColor
      
        textfield.layer.borderWidth = 0
        textfield.layer.borderColor = UIColor.clear.cgColor
    }
    

   

}
