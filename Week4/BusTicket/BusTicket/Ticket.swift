//
//  Ticket.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import Foundation

struct Ticket {
    var passenger: Passenger?;
    var date: Date?;
    var time: Time?;
    var selectedSeats: [Int] = [];
    var numberOfSeats: Int = 0
    
    init(passenger: Passenger, date:Date, time:Time) {
        self.passenger = passenger;
        self.date = date;
        self.time = time;
    }
    
    init(){
        passenger = nil;
        date = nil;
        time = nil;
        selectedSeats = [];
        numberOfSeats = 0;
    }
    
    func getCopy() -> String {
        let strSeatNumbers = selectedSeats.map{String($0 + 1)}.joined(separator: ", ")
        return strSeatNumbers;
    }
    
}
