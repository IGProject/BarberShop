//
//  OurTeamDetailViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
import GoogleMaps
class OurTeamDetailViewController: UIViewController {

   //MARK:Outlet Connection
  
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageTeam: UIImageView!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var navigationItemTitle: UINavigationItem!
  
  
  //MARK: Properties
  var usernameString:String!
  var phoneString:String!
  var emailString:String!
  var descriptionString: String!
  var imageTeamString: String!
  var latitude: Double!
  var longtitude: Double!
  var locationName: String!
  
  //URL
  let teamEndPoint = URL(string: Domains.BaseURL)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setupViews()
      setupGoogleMap()
      setupClearNavigation()
    }
  
  @IBAction func backItemTapped(_ sender: UIBarButtonItem) {
      navigationController?.dismiss(animated: true)
  }
  
  private func setupViews(){
    navigationItemTitle.title = usernameString
    usernameLabel.text = usernameString
    phoneNumberLabel.text = phoneString
    emailLabel.text = emailString
    descriptionLabel.text = descriptionString
    let urlImage = teamEndPoint?.appendingPathComponent(imageTeamString)
    imageTeam.kf.setImage(with: urlImage)
  }
  
  private func setupGoogleMap(){
    let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom: 10.0)
    googleMapView.camera = camera

    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    marker.snippet = locationName
    marker.map = googleMapView
  }
  
  private func setupClearNavigation() {
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
  
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  @IBAction func teamBookingTapped(_ sender: RoundButton) {
  
    let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    booking.teamName = usernameString
    booking.locationAddress = locationName
   self.navigationController?.present(booking, animated: true)
  }
  
}
