//
//  LocationViewController.swift
//  ImageTableView
//
//  Created by semra on 10.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    var locationName: String?
    var notificationData: [String: Any] = [:]
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var aptNumber: UITextField!
    
    
    @IBOutlet weak var doorNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.7);

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
       
        locationLabel.text = locationName ?? "";
        
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        if let locationNameLast = locationName, let aptNo = aptNumber.text, let doorNo = doorNumber.text, aptNo.count > 0 && doorNo.count > 0 {
            notificationData["name"] = locationNameLast + " \(aptNo)" + " \(doorNo)";
            NotificationCenter.default.post(name: .sendDataNotification, object: nil, userInfo: notificationData)
            dismiss(animated: true, completion: nil)
            
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Text fields cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
