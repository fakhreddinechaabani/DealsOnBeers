//
//  UIViewController+Identifier.swift
//  DealsOnBeers
//
//  Created by fakhreddine chaabani on 3/3/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//



import UIKit

extension UIViewController {
    static var storyboardIdentifier : String {
        return String(describing: self)
    }
}

