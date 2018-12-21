//
//  MapLocationViewController.swift
//  BarberShop-V2
//
//  Created by User on 6/5/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import GoogleMaps
import Kingfisher
class MapLocationViewController: UIViewController {
    
  @IBOutlet weak var navigationBar: UINavigationBar!
  
  @IBOutlet weak var imageLocation: UIImageView!
  @IBOutlet weak var addressLocation: UILabel!
  @IBOutlet weak var phoneLocation: UILabel!
  @IBOutlet weak var timeLocation: UILabel!
  
  @IBOutlet weak var googleMapView: GMSMapView!
  @IBOutlet weak var mapItemTitle: UINavigationItem!
  
  //MARK: Properties
    var zoom: Float = 14.0
    var imageString:String!
    var addressString: String!
    var phoneString: String!
    var timeString: String!
    var latitude: Double!
    var longitude: Double!
    var address:String!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGoogleMapMarkerInit()
        setupClearNavigation()
      getLocationDetail()
    }
  
  
  func getLocationDetail(){
    let url = URL(string: Domains.BaseURL)!
    let urlLocation = url.appendingPathComponent(imageString)
    imageLocation.kf.setImage(with: urlLocation)
    addressLocation.text = addressString
    phoneLocation.text = phoneString
    timeLocation.text = timeString
  }
  
  func setupClearNavigation() {
    mapItemTitle.title = address
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.backgroundColor = .clear
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
  
    func setupGoogleMapMarkerInit(){
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        self.googleMapView.camera = camera
      
      let marker = GMSMarker()
      marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      marker.snippet = address
      marker.map = googleMapView
      
        self.googleMapView.isMyLocationEnabled = true
      
      
    }
  
  
    
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func BookingLocationTapped(_ sender: RoundButton) {
    
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
