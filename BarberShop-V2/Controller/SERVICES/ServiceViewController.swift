//
//  ServiceViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
class ServiceViewController: UIViewController {
  
  //MARK: Outlet Connection
  @IBOutlet weak var serviceCollectionView: UICollectionView!
  
  //MARK: Properties
  var itemServices = [Services.Results]()
  var itemsService = Services(length:0,results:[])
  private let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
       loadData()
     self.addNotificationChangeLanguage()
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
    self.serviceCollectionView.reloadData()
  }
  
  private func setCollection(){
    serviceCollectionView.delegate = self
    serviceCollectionView.dataSource = self
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Service Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      serviceCollectionView.refreshControl = refreshControl
    }else {
      serviceCollectionView.addSubview(refreshControl)
    }
    
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshServiceData), for: .valueChanged)
  }
  
  @objc private func refreshServiceData(_ sender:Any){
    //Fetch Team Data
    self.setupCollectionData()
  }
  
  // Load data in the tableView
  private func loadData() {
    // Simulate a delay of some operations as a HTTP Request
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
      self.setCollection()
      self.setupCollectionData()
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
    loadingView.removeFromSuperview()
    
    
  }
  
  private func setupCollectionData(){
    let serviceEndPoint = URL(string: Domains.BaseURL + "/seva/list")
    getItemTeam(serviceEndPoint: serviceEndPoint!)
  }
  
  private func getItemTeam(serviceEndPoint: URL){
    
    Alamofire.request(serviceEndPoint).validate().responseJSON { response in
      switch response.result {
      case .success(_):
        let jsonData = response.data
        do {
          let jsonDecoder = JSONDecoder()
          let serviceResponse = try jsonDecoder.decode(Services.self, from: jsonData!)
          self.itemsService = Services(length: serviceResponse.length, results: serviceResponse.results)
          self.serviceCollectionView.reloadData()
          self.refreshControl.endRefreshing()
          
        }catch let error {
          print(error)
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
  }
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) { }
  
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.dismiss(animated: true)
  }
  
}

extension ServiceViewController: ServiceBookingCellDelegate {
  func didTapServiceBooking(_ T: ServiceCollectionCell,_ data:Services.Results) {
    let storyboard:UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    booking.serviceTitle = data.title
    booking.serviceId = data.id
    
    booking.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(booking, animated: true)
  }
  
  
}

extension ServiceViewController: UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    serviceDetailCollectionCell(detailService: itemsService.results[indexPath.row])
  }
  
  func serviceDetailCollectionCell(detailService:Services.Results){
    
    let storyBoard: UIStoryboard = UIStoryboard(storyboard: .Service)
    let serviceDetail = storyBoard.instantiateViewController(withIdentifier: "ServiceDetailViewController") as! ServiceDetailViewController
    
    serviceDetail.titleServiceString = detailService.title
    serviceDetail.priceServiceString = detailService.price
    serviceDetail.pointServiceString = String(detailService.point)
    serviceDetail.desServiceString = detailService.description
    serviceDetail.imageDetail = detailService.seva_profiles.map({ return $0.file_path})
    
    serviceDetail.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(serviceDetail, animated: true)
  }
  
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfColumns: CGFloat = 1
    let width = collectionView.frame.size.width
    let xInsets:CGFloat = 5
    let cellSpacing: CGFloat = 5
    
    return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 275)
  }
}
