//
//  TicketViewController.swift
//  BusTicket
//
//  Created by semra on 27.07.2021.
//

import UIKit

class TicketViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var seatCollectionView: UICollectionView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var seatID: UILabel!
    
    var ticket: Ticket?
    
    
    var classTitle = SeatPositions.classTitle;
    var seatCount: Int = 0
    var maxSelectableSeatCount = 0;
    
    var selectedSeatNumbers: [Int] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImage.layer.cornerRadius = 5
        posterImage.layer.masksToBounds = true
        
      
    }
    
    @IBAction func payButtonPressed(_ sender: Any) {
        if(seatCount < maxSelectableSeatCount){
            let alert = UIAlertController(title: "Alert", message: "You have not reached the maximum number of seats you can select.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                    (result: UIAlertAction) -> Void in
                    })
                    self.present(alert, animated: true, completion: nil)
            return
        }
        
        let strSeatNumbers = selectedSeatNumbers.map{String($0 + 1)}.joined(separator: ",")
        let message = "\(strSeatNumbers) seat numbers are selected. Are you sure you want to continue?"
        
        let refreshAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (action: UIAlertAction!) in
            for item in self.selectedSeatNumbers {
                if item <= 19 {
                    SeatPositions.seatLayout[self.classTitle[0]]![item] = 1;
                }
                else {
                   let newItem = item - 20;
                    SeatPositions.seatLayout[self.classTitle[1]]![newItem] = 1;
                    
                }
            }
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ticketbuyed") as! TicketSeatViewController;
            self.ticket?.selectedSeats = self.selectedSeatNumbers;
            viewController.ticket = self.ticket;
            self.navigationController?.pushViewController(viewController, animated: true);
              
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        selectedSeatNumbers = [];
        self.navigationItem.setHidesBackButton(false, animated: false)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (SeatPositions.seatLayout[classTitle[section]]?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as! SeatCell
        if SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row] == 0 {
            cell.seat.image = nil
        }else if SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row] == 1 {
            cell.seat.image = #imageLiteral(resourceName: "filled")
        }else if SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row] == 2 {
            cell.seat.image = #imageLiteral(resourceName: "unFilled")
        }else{
            cell.seat.image = #imageLiteral(resourceName: "selected")
        }
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row]  != 0 && SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row]   != 1 {
            
            if SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row]  != 3{
                if(seatCount >= maxSelectableSeatCount){
                    let alert = UIAlertController(title: "Alert", message: "You have reached the maximum number of seats you can select.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                            (result: UIAlertAction) -> Void in
                            })
                            self.present(alert, animated: true, completion: nil)
                }
                else{
                    seatCount += 1
                    SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row]   = 3
                    if seatCount == 1{
                        showBottomView()
                    }
                    selectedSeatNumbers.append(indexPath.section * 20  + indexPath.row)
                    setSeatCount();
                }
            }else{
                SeatPositions.seatLayout[classTitle[indexPath.section]]![indexPath.row]   = 2
                seatCount -= 1
                if seatCount == 0{
                    hideBottomView()
                }
                selectedSeatNumbers = selectedSeatNumbers.filter { $0 != indexPath.section * 20  + indexPath.row }
                setSeatCount();
            }
            seatCollectionView.reloadData()
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "The seat you have selected has been reserved. Please choose from green seats.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default) {
                    (result: UIAlertAction) -> Void in
                    })
                    self.present(alert, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth = (view.frame.width/10)-10
        return CGSize(width: deviceWidth, height: deviceWidth)
    }

    func showBottomView(){
        seatCollectionView.scrollsToTop = true
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 50
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    func hideBottomView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    
    func setSeatCount(){
        seatID.text = "\(seatCount) Seat"
    }
}


