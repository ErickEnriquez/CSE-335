//
//  map_ViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/15/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class map_ViewController: UIViewController , CLLocationManagerDelegate {
    @IBOutlet weak var map_view: MKMapView!//outlet to the mapview oulet
    var manager = CLLocationManager()
    var annotation = MKPointAnnotation()
    var selectedAnnotation: MKPointAnnotation?
    var matchingItems:[MKMapItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()

      /*  // Ask for Authorization from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()*/
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
       // manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        
        
        }
    

class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
  
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc: CLLocationCoordinate2D = manager.location?.coordinate else { return }//should use this instead
      //  let span = MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)
      //  let region = MKCoordinateRegion(center: loc, span: span)
      //  self.map_view.setRegion(region, animated: true)
        annotation.coordinate = loc.self
        annotation.title = "My Location"
        map_view.addAnnotation(annotation)
        map_view.isScrollEnabled = true
        map_view.isZoomEnabled = true
    
    //userLocation - there is no need for casting, because we are now using CLLocation object
    
    
    
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    
    
    @IBAction func search_chicken(_ sender: Any) {
        self.map_view.removeAnnotations(self.map_view.annotations)
        let item  = "Chicken"
       // print("SEARCHING ", item)
        let request = MKLocalSearch.Request()//create a request
        request.naturalLanguageQuery = item//give it the type of stuff we are looking for
        request.region = map_view.region//set the region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
             print( response.mapItems )
           
            self.matchingItems = response.mapItems
            for i in 0...self.matchingItems.count - 1
            {
                let place = self.matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                self.map_view.addAnnotation(ani)
            }
        }
        map_view.isScrollEnabled = true
        map_view.isZoomEnabled = true
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
