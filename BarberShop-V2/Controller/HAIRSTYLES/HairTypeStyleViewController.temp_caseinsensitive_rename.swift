//
//  HairtypeStyleViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class HairTypeStyleViewController: UIViewController {
    
    @IBOutlet weak var styleTypeCollectionView: UICollectionView!
  var itemHairStyle = [StyleHair.Results]()
  var listHairStyleDataSource = ListHairStyleDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       setupCollectionView()
       render()
       setupDataStyleTypeList()
    }
  
  private func setupCollectionView(){
    styleTypeCollectionView.delegate = self
   styleTypeCollectionView.dataSource = listHairStyleDataSource
  }
  
  private func render(){
    styleTypeCollectionView.reloadData()
  }
  
  private func setupDataStyleTypeList(){
    
  }

}

extension HairTypeStyleViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 0.5
    }
}

extension HairTypeStyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 3
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
    }
}
