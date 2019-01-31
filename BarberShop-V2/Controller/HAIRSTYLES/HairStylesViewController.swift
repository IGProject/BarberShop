//
//  HairStylesViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
class HairStylesViewController: UIViewController {
    
    @IBOutlet weak var hairStyleCollectionView: UICollectionView!
  
  var itemsHairStyle = StyleHair(length:0,results:[])
  var listHairStyleDataSource = ListHairStyleDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupCollectionView()
      setupDataStyleList()
     // setupClearNavigation()
    }
  
//  func setupClearNavigation() {
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    self.navigationController?.navigationBar.shadowImage = UIImage()
//    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
//  }
  
  private func setupCollectionView(){
    hairStyleCollectionView.delegate = self
    hairStyleCollectionView.dataSource = listHairStyleDataSource
  }
  
  private func render(){
    let hairStyles = itemsHairStyle.results.map { return $0}
    listHairStyleDataSource.listStyleHair.results = hairStyles
    hairStyleCollectionView.reloadData()
  }
  
  private func setupDataStyleList(){
    let styleTypeEndPoint = URL(string: Domains.BaseURL + "/style/list")!
    Alamofire.request(styleTypeEndPoint).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do {
          let jsonDecoder = JSONDecoder()
          let hairStyleResponse = try jsonDecoder.decode(StyleHair.self, from: jsonData!)
          self.itemsHairStyle = StyleHair(length: hairStyleResponse.length, results:   hairStyleResponse.results)
            self.render()
        }catch let eror {
          print(eror.localizedDescription)
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
        
      }
    }
  }
  
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        
         navigationController?.dismiss(animated: true)
    }
  
}

extension HairStylesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        cell?.layer.borderWidth = 2
      
      let hairTypeDetails = itemsHairStyle.results[indexPath.item]
      let storyBoard: UIStoryboard = UIStoryboard(storyboard: .Hairstyle)
      let hairDetail = storyBoard.instantiateViewController(withIdentifier: "HairTypeStyleViewController") as! HairTypeStyleViewController
      
      hairDetail.navigationItem.title = hairTypeDetails.shape.shape_name
      hairDetail.navigationController?.navigationBar.isTranslucent = false
      hairDetail.imageStyleTypeString = hairTypeDetails.style_profiles.map({ $0.file_path})
      
      hairDetail.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(hairDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 0.5
    }
}

extension HairStylesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 5
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 183)
    }
}
