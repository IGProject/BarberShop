//
//  OurTeamBarberViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire


class OurTeamBarberViewController: UIViewController{
  @IBOutlet weak var teamCollectionView: UICollectionView!
  
  
  
  @IBOutlet weak var loadingViews: UIView!
  @IBOutlet weak var spinners: UIActivityIndicatorView!
  @IBOutlet weak var loadingLabels: UILabel!
  
  private let refreshControl = UIRefreshControl()
  var itemsTeam = Teams(length:0,results:[])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLoadingScreen()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.addNotificationChangeLanguage()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.teamCollectionView.reloadData()
    NotificationCenter.default.removeObserver(self)
  }
  
  func addNotificationChangeLanguage(){
    NotificationCenter.default.addObserver(self, selector: #selector(doOnLangaue), name: NSNotification.Name(rawValue: Domains.notificationLanguage), object: nil)
  }
  
  @objc func doOnLangaue(){
    self.teamCollectionView.reloadData()
  }
  
  private func setupListTeam(){
    let teamEndPoint = URL(string: Domains.BaseURL + "/team/list")
    getItemTeam(teamsEndPoint: teamEndPoint!)
  }
  
  
  func getCollectionView(){
    teamCollectionView.delegate = self
    teamCollectionView.dataSource = self
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Team Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      teamCollectionView.refreshControl = refreshControl
    }else {
      teamCollectionView.addSubview(refreshControl)
    }
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshTeamData), for: .valueChanged)
  }
  
  @objc private func refreshTeamData(_ sender:Any){
    //Fetch Team Data
    self.setupListTeam()
  }
  
  private func getItemTeam(teamsEndPoint:URL!){
    Alamofire.request(teamsEndPoint).validate().responseJSON { (response) in
      switch response.result {
      case .success(_):
        let json = response.data
        
        do {
          let jsonDecoder = JSONDecoder()
          let teamsResponse = try jsonDecoder.decode(Teams.self, from: json!)
          self.itemsTeam = Teams(length: teamsResponse.length, results: teamsResponse.results)
          self.teamCollectionView.reloadData()
          self.refreshControl.endRefreshing()
        }catch let err {
          print(err)
        }
      case .failure(let error):
        print("error:",error.localizedDescription)
      }
      
    }
  }
  // MARK: Private methods
  
  // Load data in the tableView
  private func loadData() {
    // Simulate a delay of some operations as a HTTP Request
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
      self.setupListTeam()
      self.getCollectionView()
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
    label.textAlignment = .center
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
  
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.dismiss(animated: true)
  }
  
}

//Delegate Button Tapped
extension OurTeamBarberViewController: TeamBookingCellDelegate {
  func didTapTeamBooking(_ T: OurTeamCollectionCell,_ data:Teams.Results) {
    let storyboard: UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    booking.teamName = data.username
    booking.teamId = data.id
    booking.locationAddress = data.location.address
    booking.locationId = data.location.id
    booking.hidesBottomBarWhenPushed = true
    self.navigationController?.pushViewController(booking, animated: true)
  }
}


//MARK:OurTeamBarberViewController: Delegate
extension OurTeamBarberViewController: UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    detailCollectionCell(itemTeams: itemsTeam.results[indexPath.row])
  }
  
  //MARK: Fun TeamdetailCollectionCell
  func detailCollectionCell(itemTeams:Teams.Results){
    let storyBoard: UIStoryboard = UIStoryboard(name: "OurTeam", bundle: nil)
    let teamDetail = storyBoard.instantiateViewController(withIdentifier: "OurTeamDetailViewController") as! OurTeamDetailViewController
    
    teamDetail.imageTeamString = itemTeams.team_profile
    teamDetail.descriptionString = itemTeams.description
    teamDetail.emailString = itemTeams.email
    teamDetail.phoneString = itemTeams.phone
    teamDetail.usernameString = itemTeams.username
    teamDetail.latitude = Double(itemTeams.location.latitude)
    teamDetail.longtitude = Double(itemTeams.location.longitude)
    teamDetail.locationName = itemTeams.location.address
    
    teamDetail.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(teamDetail, animated: true)
  }
  
}

extension OurTeamBarberViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfColumns: CGFloat = 1
    let width = collectionView.frame.size.width
    let xInsets:CGFloat = 5
    let cellSpacing: CGFloat = 5
    return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 284)
  }
}
