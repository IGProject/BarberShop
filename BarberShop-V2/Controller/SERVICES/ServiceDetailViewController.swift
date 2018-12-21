//
//  ServiceDetailViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Kingfisher
class ServiceDetailViewController: UIViewController {
  
  //MARK: Outlet Connection
    @IBOutlet weak var title_service: UILabel!
    @IBOutlet weak var price_service: UILabel!
    @IBOutlet weak var point_service: UILabel!
    @IBOutlet weak var des_service: UILabel!
    @IBOutlet weak var navigationTitle: UINavigationItem!
  
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var serviceDetailCollectionView: UICollectionView!
  
  //MARK: Properties
  var titleServiceString:String!
  var priceServiceString:String!
  var pointServiceString:String!
  var desServiceString:String!
  
  var imageDetail = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupClearNavigation()
      setCollection()
      setupViewService()
    }
  
  private func setupClearNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
  private func setCollection(){
    serviceDetailCollectionView.delegate = self
    serviceDetailCollectionView.dataSource = self
    
  }
  
  private func setupViewService(){
    navigationTitle.title = titleServiceString
    title_service.text = titleServiceString
    price_service.text = priceServiceString
    point_service.text = pointServiceString
    des_service.text = desServiceString
  }
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func serviceBookingTapped(_ sender: RoundButton) {
    let storyboard:UIStoryboard = UIStoryboard(storyboard: .Booking)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
   booking.serviceTitle = titleServiceString
  self.navigationController?.pushViewController(booking, animated: true)
  }
  
}


extension ServiceDetailViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 0.5
    }
}

extension ServiceDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 132)
    }
}
