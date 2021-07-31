//
//  Time.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import Foundation

struct Time {
    
    var hour: String = "00";
    var minute: String = "00" ;
    
    init(hour: String, minute:String){
        self.hour = hour;
        self.minute = minute;
    }
    
    func getCopy() -> String {
        return "\(hour):\(minute)";
    }
    
}
