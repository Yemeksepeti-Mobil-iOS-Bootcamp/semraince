//
//  Passenger.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import Foundation

struct Passenger {
    let name: String;
    let surname: String;
    var id : Int = 0;
    
    init(name: String, surname: String, id: Int) {
        self.name = name;
        self.surname = surname;
        self.id = id;
    }
    
    func getCopy() -> String{
        return "\(name) \(surname) \(id)";
    }
}
