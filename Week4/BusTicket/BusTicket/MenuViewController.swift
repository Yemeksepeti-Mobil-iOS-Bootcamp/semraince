//
//  MenuViewController.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var surnameLabel: UITextField!
    
    
    @IBOutlet weak var ticketNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var stepper: UIStepper!
    
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var ticket: Ticket?
    
    var emptySeats = 0;
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy";
        if let date = dateFormatter.date(from: "01/01/2021"){
            datePicker.date = date;
        }
        dateFormatter.dateFormat = "HH:mm";
        if let date = dateFormatter.date(from: "00:00"){
            timePicker.date = date;
        }
        nameLabel.text = "";
        surnameLabel.text = "";
        stepper.value = 0;
        ticketNumber.text = "0";
        nameLabel.becomeFirstResponder();
        
        for(index, item) in SeatPositions.seatLayout.enumerated()
            {
            var i = 0;
            for number in item.value {
                if number == 3 {
                    emptySeats += 1;
                    
                    SeatPositions.seatLayout[item.key]![i] = 2;
                }
                if (number == 2){
                    emptySeats += 1;
                }
                i += 1;
            }
            
              }
        
        
        
    }
    
    
    
    @IBAction func ticketIncrementerTapped(_ sender: UIStepper) {
        let numberOfTickets = Int(sender.value);
        if numberOfTickets > 5 {
            stepper.value = 5;
            let alert = UIAlertController(title: "Alert", message: "The maximum number of tickets that can be selected is five.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                    (result: UIAlertAction) -> Void in
                    })
                    self.present(alert, animated: true, completion: nil)
            return;
        }
        
        ticketNumber.text = String(numberOfTickets);
            
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let name = nameLabel.text;
        let surname = surnameLabel.text;
        
        guard let nameImp = name, let surnameImp = surname , nameImp.count > 0 , surnameImp.count > 0 else {
            let alert = UIAlertController(title: "Alert", message: "Name and surname cannot be empty.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                    (result: UIAlertAction) -> Void in
                    })
                    self.present(alert, animated: true, completion: nil)
            return;
        }
        let numberOfSeats = Int(ticketNumber.text!)!;
        if numberOfSeats > emptySeats {
            let alert = UIAlertController(title: "Alert", message: "The number of seats selected exceeds the number of available seats.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                    (result: UIAlertAction) -> Void in
                    })
                    self.present(alert, animated: true, completion: nil)
            return;
        }
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy";
        let year = dateFormatter.string(from: datePicker.date);
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from:self.datePicker.date);
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from:self.datePicker.date);
        dateFormatter.dateFormat = "HH";
        let hour = dateFormatter.string(from: timePicker.date);
        dateFormatter.dateFormat = "mm";
        let minute = dateFormatter.string(from: timePicker.date);
        let date = Date(day: day, month: month, year: year)
        let time = Time(hour: hour, minute: minute);
        print(hour);
        print(minute)
        let id = Int.random(in: 1..<10000)
        let passenger = Passenger(name: nameImp, surname: surnameImp, id: id);
        ticket = Ticket(passenger: passenger, date: date, time: time);
        
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TicketController") as! TicketViewController;
        viewController.ticket = ticket;
        viewController.maxSelectableSeatCount = numberOfSeats;

        self.navigationController?.pushViewController(viewController, animated: true);
    }
    


}
