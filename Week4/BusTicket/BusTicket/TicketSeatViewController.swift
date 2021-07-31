//
//  TicketSeatViewController.swift
//  BusTicket
//
//  Created by semra on 28.07.2021.
//

import UIKit

class TicketSeatViewController: UIViewController {
    
    var ticket: Ticket?
    
    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var dateField: UILabel!
    
    @IBOutlet weak var timeField: UILabel!
    
    @IBOutlet weak var seatField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationItem.setHidesBackButton(true, animated: false)
        nameField.text = ticket?.passenger?.getCopy();
        dateField.text = ticket?.date?.getCopy();
        timeField.text = ticket?.time?.getCopy();
        seatField.text = ticket?.getCopy();
        
    }
    
    
    @IBAction func buyTicketPressed(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    

}
