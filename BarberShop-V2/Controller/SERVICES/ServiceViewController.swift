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
  
    override func viewDidLoad() {
        super.viewDidLoad()

         setCollection()
         setupCollectionData()
         setupClearNavigation()
    }
  
  private func setCollection(){
    serviceCollectionView.delegate = self
    serviceCollectionView.dataSource = self
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
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    }
}

extension ServiceViewController: ServiceBookingCellDelegate {
  func didTapServiceBooking(_ T: ServiceCollectionCell,_ data:Services.Results) {
    let storyboard:UIStoryboard = UIStoryboard(name: "Booking", bundle: nil)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    booking.serviceTitle = data.title
    booking.serviceId = data.id
    navigationController?.present(booking, animated: true)
  }
  
  
}

extension ServiceViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 2
      serviceDetailCollectionCell(detailService: itemsService.results[indexPath.row])
    }
  
  func serviceDetailCollectionCell(detailService:Services.Results){
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Service", bundle: nil)
    let serviceDetail = storyBoard.instantiateViewController(withIdentifier: "ServiceDetailViewController") as! ServiceDetailViewController
    
    serviceDetail.titleServiceString = detailService.title
    serviceDetail.priceServiceString = detailService.price
    serviceDetail.pointServiceString = String(detailService.point)
    serviceDetail.desServiceString = detailService.description
    serviceDetail.imageDetail = detailService.seva_profiles.map({ return $0.file_path!})
    navigationController?.present(serviceDetail, animated: true)
  }
  
 
  
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 0.5
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
