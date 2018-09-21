//
//  MapLocationViewController.swift
//  BarberShop-V2
//
//  Created by User on 6/5/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import GoogleMaps
class MapLocationViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var zoom: Float = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleMapMarkerInit()
    }

    func setupGoogleMapMarkerInit(){
        let camera = GMSCameraPosition.camera(withLatitude: 11.53319, longitude: 104.90968, zoom: 15.0)
        self.googleMapView.camera = camera
        self.googleMapView.isMyLocationEnabled = true
        
    }
    
    @IBAction func collectionMapDestinationTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            zoom = zoom + 1
            self.googleMapView.animate(toZoom: zoom)
        case 1:
            zoom = zoom - 1
            self.googleMapView.animate(toZoom: zoom)
        case 2:
            setupGoogleMapMarkerInit()
        default:
            print("nothing")
        }
    }
}
