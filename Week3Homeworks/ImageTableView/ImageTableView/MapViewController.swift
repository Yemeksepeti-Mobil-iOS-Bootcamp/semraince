//
//  MapViewController.swift
//  ImageTableView
//
//  Created by semra on 10.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    @IBOutlet weak var locationField: UILabel!
    var location: String?;
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    

   override func viewDidLoad() {
          super.viewDidLoad()

          // Do any additional setup after loading the view.
          checkLocationServices()
            let notificationCenter: NotificationCenter = NotificationCenter.default
                   
                   notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)

      }
    @objc func handleData(notification: Notification) {
        
        if let name = notification.userInfo?["name"] as? String {
            locationField.text = name ?? "";
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
      func setupLocationManager() {
          locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self;
      }
      
      func showUserLocationCenterMap() {
          if let location = locationManager.location?.coordinate {
              let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 100, longitudinalMeters: 100)
              mapView.setRegion(region, animated: true)
          }
      }
    
    @IBAction func getLocationTapped(_ sender: Any) {
        if let locationAddress = location, locationAddress.count > 0 {
            let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "locationVC") as! LocationViewController;
                   senderVC.locationName = location;
                    present(senderVC, animated: true, completion: nil);
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Couldnot retrive region info", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
       
        
    }
    
      
      func checkLocationServices() {
          if CLLocationManager.locationServicesEnabled() {
              setupLocationManager()
              checkLocationAuthorization()
          } else {
              //TODO: Kullanıcıya ayarlardan konum servisini açması istenebilir
          }
      }
      
      func checkLocationAuthorization() {
          switch CLLocationManager.authorizationStatus() {
          case .authorizedWhenInUse:
              /*mapView.showsUserLocation = true
              showUserLocationCenterMap()
              locationManager.startUpdatingLocation()*/
          //Pinleme sonrası
          trackingLocation()
          case .denied:
              break
          case .notDetermined:
              locationManager.requestWhenInUseAuthorization()
          case .authorizedAlways:
              break
          case .restricted:
              break
          }
      }
      
      //Pinlediğim yeri izle
      func trackingLocation() {
          mapView.showsUserLocation = true
          showUserLocationCenterMap()
          locationManager.startUpdatingLocation()
          lastLocation = getCenterLocation(mapView: mapView)
      }
      
      func getCenterLocation(mapView: MKMapView) -> CLLocation {
          let latitude = mapView.centerCoordinate.latitude
          let longitude = mapView.centerCoordinate.longitude
          
          return CLLocation(latitude: latitude, longitude: longitude)
      }
}
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
extension MapViewController: MKMapViewDelegate {
       
       func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
           
           let center = getCenterLocation(mapView: mapView)
           let geoCoder = CLGeocoder()
           
           guard let lastLocation = lastLocation else { return }
           
           guard center.distance(from: lastLocation) > 30 else { return }
           self.lastLocation = center
           
           geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
               
               guard let self = self else { return }
               
               if let error = error {
                   print(error)
                   return
               }
               
               guard let placemark = placemarks?.first else { return }
               
               let city = placemark.locality ?? "City"
               let street = placemark.thoroughfare ?? "Street"
            let country = placemark.country ?? "";
            self.location = "\(street) " + "\(city) " + "\(country)";

               
           }
       }
       
   }
