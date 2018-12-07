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
  
  //MARK:Properties
  var mLocatonResult = Locations(length:0,results:[])
    override func viewDidLoad() {
        super.viewDidLoad()
      setupCollectionView()
      setupDataByLocation()
    }
  
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  private func setupCollectionView(){
    collectionViewLocation.delegate = self
    collectionViewLocation.dataSource = self
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
    
    navigationController?.present(booking, animated: true)
  }
}

extension ByLocationViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        cell?.layer.borderWidth = 2
      
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

    navigationController?.present(locationDetail, animated: true)
  }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        cell?.layer.borderWidth = 0.5
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
