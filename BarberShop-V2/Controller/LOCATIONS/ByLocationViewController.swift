//
//  ByLocationViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire


class ByLocationViewController: UIViewController {
  //MARK: Outlet Connection
    @IBOutlet weak var collectionViewLocation: UICollectionView!
  /// View which contains the loading text and the spinner
 
  private let refreshControl = UIRefreshControl()
  //MARK:Properties
  var mLocatonResult = Locations(length:0,results:[])
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
      self.collectionViewLocation.reloadData()
     NotificationCenter.default.removeObserver(self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadData()
    addNotificationChangeLanguage()
  }
  
  override func viewDidAppear(_ animated: Bool) {
   super.viewDidAppear(animated)
    setLoadingScreen()
    loadData()
  }
  
  
  func addNotificationChangeLanguage(){
    NotificationCenter.default.addObserver(self, selector: #selector(doOnLangaue), name: NSNotification.Name(rawValue: Domains.notificationLanguage), object: nil)
  }
  
  @objc func doOnLangaue(){
    self.collectionViewLocation.reloadData()
  }
  
  // Load data in the tableView
  private func loadData() {
    // Simulate a delay of some operations as a HTTP Request
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
      
      self.setupCollectionView()
      self.setupDataByLocation()
      self.removeLoadingScreen()
      
    }
    
  }
  
  // Set the activity indicator into the main view
  private func setLoadingScreen() {
    
    // Adds text and spinner to the view
    view.addSubview(loadingView)
    loadingView.addSubview(spinner)
    loadingView.addSubview(loadingLabel)
    
    
    
    
    // Sets the view which contains the loading text and the spinner
    let width: CGFloat = 120
    let height: CGFloat = 50
    
    
    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadingView.widthAnchor.constraint(equalToConstant: width).isActive = true
    loadingView.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    spinner.leftAnchor.constraint(equalTo: loadingView.leftAnchor, constant: 5).isActive = true
    spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
    spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
    spinner.startAnimating()
    
    
    // Sets loading text
    loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    loadingLabel.leftAnchor.constraint(equalTo: spinner.rightAnchor, constant: 5).isActive = true
    
    
    
  }
  
  lazy var loadingView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let loadingLabel: UILabel = {
    let label  = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = COlorCustom.hexStringToUIColor(hex: "#00695C")
    label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: Loading.loadingTitleKey.rawValue, comment: "")
    return label
  }()
  
  let spinner: UIActivityIndicatorView = {
    let indecator = UIActivityIndicatorView()
    indecator.translatesAutoresizingMaskIntoConstraints = false
    indecator.activityIndicatorViewStyle = .gray
    indecator.color = COlorCustom.hexStringToUIColor(hex: "#00695C")
    return indecator
  }()
  
  
  // Remove the activity indicator from the main view
  private func removeLoadingScreen() {
    
    // Hides and stops the text and the spinner
    spinner.stopAnimating()
    //    spinner.isHidden = true
    //   loadingLabel.isHidden = true
    // loadingView.isHidden = true
    loadingView.removeFromSuperview()
    
    
  }
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  private func setupCollectionView(){
    collectionViewLocation.delegate = self
    collectionViewLocation.dataSource = self
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching ByLocation Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      collectionViewLocation.refreshControl = refreshControl
    }else {
      collectionViewLocation.addSubview(refreshControl)
    }
    
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshByLocationData), for: .valueChanged)
  }
  
  @objc private func refreshByLocationData(_ sender:Any){
    //Fetch Team Data
    self.setupDataByLocation()
  }
  
  private func setupDataByLocation(){
    let byLocationEndPoint = URL(string: Domains.BaseURL + "/location/list")!
    Alamofire.request(byLocationEndPoint).validate().responseJSON { response in
      switch response.result {
      case .success(_):
        let dataJson = response.data
        do {
          let jsonDecoder = JSONDecoder()
          let byLocationResponse = try jsonDecoder.decode(Locations.self, from: dataJson!)
          
          self.mLocatonResult = Locations(length: byLocationResponse.length,results: byLocationResponse.results)
          self.collectionViewLocation.reloadData()
          self.refreshControl.endRefreshing()
        }catch let error {
          print(error)
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
  }
}


extension ByLocationViewController: LocationBookingCellDelegate{

  func didTapLocationBooking(_ T: ByLocationCollectionCell,_ data:Locations.Results,_ team: Locations.Results) {
   
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Booking)
      let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
      booking.locationAddress = data.address
      booking.locationId = data.id
      booking.teamName = team.team.count == 0 ? "": team.team[0].username
      booking.teamId = team.team.count == 0 ? 0: team.team[0].id
    
      booking.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(booking, animated: true)
    
  }
}

extension ByLocationViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
//        cell?.layer.borderWidth = 2
      
      locationDetailCollectionCell(itemsLocation: mLocatonResult.results[indexPath.row])
    }
  
  func locationDetailCollectionCell(itemsLocation: Locations.Results){
    let storyBoard: UIStoryboard = UIStoryboard(name: "Location", bundle: nil)
    let locationDetail = storyBoard.instantiateViewController(withIdentifier: "MapLocationViewController") as! MapLocationViewController
    
    locationDetail.navigationItem.title = itemsLocation.address
    locationDetail.navigationController?.navigationBar.isTranslucent = false
    locationDetail.latitude = Double(itemsLocation.latitude)
    locationDetail.longitude = Double(itemsLocation.longitude)
    locationDetail.address = itemsLocation.address
    locationDetail.addressString = itemsLocation.address
    locationDetail.phoneString = itemsLocation.phone
    locationDetail.timeString = itemsLocation.work_time
    locationDetail.imageString = itemsLocation.location_profile

    navigationController?.pushViewController(locationDetail, animated: true)
  }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
//        cell?.layer.borderWidth = 0.5
    }
}

extension ByLocationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 1
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 5
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 305)
    }
}
