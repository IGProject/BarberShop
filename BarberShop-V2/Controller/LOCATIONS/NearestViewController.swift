//
//  NearestViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlace {
    var name: String
    var lat: Double
    var long: Double
}

class NearestViewController: UIViewController {
    //MARK- Outlet Connection
    @IBOutlet weak var googleMapView: GMSMapView!
    
    //Properties
    var locationManager = CLLocationManager()
    let currentLocationMarker = GMSMarker()
    var currentLocation: CLLocation?
    //var placesClient: GMSPlacesClient!
    var chosenPlace: MyPlace?
    
    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70
    
    var zoom: Float = 15
    
     let previewDemoData = [(title: "The Polar Junction", img: #imageLiteral(resourceName: "bg-barbershop"), price: 10), (title: "The Nifty Lounge", img: #imageLiteral(resourceName: "bg-barbershop"), price: 8), (title: "The Lunar Petal", img: #imageLiteral(resourceName: "bg-barbershop"), price: 12)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoogleMapMarkerInit()
        googleMapView.delegate=self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
      
        
        
    }
    
    @IBAction func myButtonLocationTapped(_ sender: UIButton) {
        let location: CLLocation? = googleMapView.myLocation
        if location != nil {
            googleMapView.animate(toLocation: (location?.coordinate)!)
        }
    }
    
    @IBAction func zoomInZoomOutTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            zoom = zoom + 1
            self.googleMapView.animate(toZoom: zoom)
            
        case 1:
            zoom = zoom - 1
            self.googleMapView.animate(toZoom: zoom)
            
        default:
            print("nothing")
        }
        
    }
    func setupGoogleMapMarkerInit(){
        let camera = GMSCameraPosition.camera(withLatitude: 11.53319, longitude: 104.90968, zoom: 15.0)
        self.googleMapView.camera = camera
         self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true

    }
}


extension NearestViewController: GMSMapViewDelegate {
    // MARK: GOOGLE MAP DELEGATE
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return false }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        marker.iconView = customMarker
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        guard let customMarkerView = marker.iconView as? CustomMarkerView else { return }
        let img = customMarkerView.img!
        let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: img, borderColor: UIColor.white, tag: customMarkerView.tag)
        marker.iconView = customMarker
    }
    
    func showPartyMarkers(lat: Double, long: Double) {
        googleMapView.clear()
        for i in 0..<3 {
            let randNum = Double(arc4random_uniform(30))/10000
            let marker = GMSMarker()
            let customMarker = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: customMarkerWidth, height: customMarkerHeight), image: previewDemoData[i].img, borderColor: UIColor.white, tag: i)
            marker.iconView = customMarker
            let randInt = arc4random_uniform(4)
            if randInt == 0 {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long-randNum)
            } else if randInt == 1 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long+randNum)
            } else if randInt == 2 {
                marker.position = CLLocationCoordinate2D(latitude: lat-randNum, longitude: long-randNum)
            } else {
                marker.position = CLLocationCoordinate2D(latitude: lat+randNum, longitude: long+randNum)
            }
            marker.map = self.googleMapView
        }
    }
}

extension NearestViewController: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let lat = (location?.coordinate.latitude)!
        let long = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        self.googleMapView.animate(to: camera)
        showPartyMarkers(lat: lat, long: long)
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
