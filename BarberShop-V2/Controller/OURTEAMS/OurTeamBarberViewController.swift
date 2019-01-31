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
  
  
  //MARK: Instance Properties
  
  var itemsTeam = Teams(length:0,results:[])
  
    override func viewDidLoad() {
        super.viewDidLoad()

    
        setCollection()
        setupListTeam()
       // setupClearNavigation()
    }
 

  
   func setCollection(){
    teamCollectionView.delegate = self
    teamCollectionView.dataSource = self
  }
  
  private func setupListTeam(){
    let teamEndPoint = URL(string: Domains.BaseURL + "/team/list")
    getItemTeam(teamsEndPoint: teamEndPoint!)
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
          
        }catch let err {
          print(err)
        }
      case .failure(let error):
        print("error:",error.localizedDescription)
      }
      
    }
  }
  
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
//  func setupClearNavigation() {
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    self.navigationController?.navigationBar.shadowImage = UIImage()
//    self.navigationController?.navigationBar.backgroundColor = .white
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
//  }
  
  
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
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
    cell?.layer.borderWidth = 2
    
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
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
    cell?.layer.borderWidth = 0.5
   
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
