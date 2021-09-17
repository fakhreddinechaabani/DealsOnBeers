//
//  costumAnnotation.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/31/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import Foundation
import Mapbox

class CustomAnno: MGLPointAnnotation {
    var willUseImg: Bool = false
    var active : Bool = false
    var name : String = ""
    var Cat : String = ""
    var adr : String = ""
    var Pne : String = ""
    var desc : String = ""
    var pic : String = ""
    var site : String = ""
    var image : UIImage?
    var startH : String = ""
    var endH : String = ""
    var highlights : String = ""
    var id : String = ""
    
}
