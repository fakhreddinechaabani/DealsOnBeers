//
//  addrecord.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/18/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import Foundation
import Firebase

class addrecord {
    let nam : String = ""
    let lat : String = ""
    let long : String = ""
    let tit : String = ""
    let adr : String = ""
    let Pne : String = ""
    let day1 : Bool = false
    let day2 : Bool = false
    let day3 : Bool = false
    let day4 : Bool = false
    let day5 : Bool = false
    let day6 : Bool = false
    let day7 : Bool = false
    let desc : String = ""
    let pic : String = ""
    let site : String = ""
    let TimeS : String = ""
    let TimeE : String = ""

    func inserttodb (name: String,lat: String,long: String,tit: String,adr: String,Pne: String,desc: String,highlights: String, pic: String,site: String, Times: String,TimeE: String,d1: Bool,d2: Bool,d3: Bool,d4: Bool,d5: Bool,d6: Bool,d7: Bool){
        let db = Firestore.firestore()
       
        db.collection("Base").document().setData([
            "Name" : name,
            "Latitude" : lat,
            "Longitude" : long,
            "Category" : tit,
            "Address" : adr,
            "Phone" : Pne,
            "day1" : d1,
            "day2" : d2,
            "day3" : d3,
            "day4" : d4,
            "day5" : d5,
            "day6" : d6,
            "day7" : d7,
            "offer" : desc,
            "picture" : pic,
            "website" : site,
            "timeStart" : Times,
            "timeEnd" : TimeE,
            "highlights" : highlights
        ]) { err in
            if err != nil {
            print ("errrrrrrrrrrrrrrrr")
            
        } else {
            print ("done")
        }
    }
    
}
}
