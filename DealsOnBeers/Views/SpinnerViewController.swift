//
//  SpinnerViewController.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/31/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
      var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
