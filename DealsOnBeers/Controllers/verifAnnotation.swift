//
//  verifAnnotation.swift
//  Angebote
//
//  Created by fakhreddine chaabani on 3/17/19.
//  Copyright © 2019 fakhreddine chaabani. All rights reserved.
//

import Foundation
class verifAnnotation  {
    
    
    
    public func verifactive( times: String, timee: String, d1 : Bool, d2 : Bool, d3 : Bool, d4 : Bool, d5 : Bool, d6 : Bool, d7 : Bool) -> Bool {
      
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let h = String(hour) + "" + String(minute)
        let current = Int(h)
        let today = calendar.component(.weekday, from: date)
        print(today)
  
        let timestart = Int(times)
        let  timeend = Int(timee)
      
        if current! >= timestart! && current! <= timeend! {
     
            if d1 == true && today == 2 {
                return true
            }else if d2 == true && today == 3 {
                return true
            } else if d3 == true && today == 4 {
                return true
            }else if d4 == true && today == 5 {
                return true
            }else if d5 == true && today == 6 {
                return true
            }else if d6 == true && today == 7 {
                return true
            }else if d7 == true && today == 1 {
                return true
            }else {
                return false
            }
        }
        else {
            return false
        }
    }
    func isactivetoaday( d1 : Bool, d2 : Bool, d3 : Bool, d4 : Bool, d5 : Bool, d6 : Bool, d7 : Bool) -> Bool {
        var active : Bool = false
        let date = Date()
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: date)
   
            
            if d1 == true && today == 2 {
                active = true
            }else if d2 == true && today == 3 {
                active = true
                
            } else if d3 == true && today == 4 {
                active = true
            }else if d4 == true && today == 5 {
                active = true
            }else if d5 == true && today == 6 {
                active = true
            }else if d6 == true && today == 7 {
                active = true
            }else if d7 == true && today == 1 {
                active = true
            }
        
        
        return active
    }
    func starting(times: String, timee: String, active: Bool) -> String {
          let date = Date()
        let calendar = Calendar.current
        var St : String = ""
        let timestart = Int(times)
        let  timeend = Int(timee)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let h = String(hour) + "" + String(minute)
        let current = Int(h)
        if active == true {
            if  current! < timestart! {
             St = "Starts soon"
            } else if current! >= timestart! && current! <= timeend! {
                St = "Active now"
            }
            else {
                St = "offer has ended"
            }
            
        }
        
        
        return St
    }
   
}
