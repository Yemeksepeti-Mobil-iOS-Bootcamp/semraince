//
//  Date.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import Foundation

struct Date {
    var year: String = "2021";
    var month: String = "1";
    var day: String = "1";
    
    init(day: String, month: String, year: String) {
        self.day = day;
        self.year = year;
        self.month = month;
    }
    
    func getCopy() -> String {
        return "\(day)/\(month)/\(year)";
    }
}
