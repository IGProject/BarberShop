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
  
  var imageStyleTypeString = [String]()
  var listHairTypeDataSource = ListHairTypeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       setupCollectionView()
       render()
    }
  
  private func setupCollectionView(){
    styleTypeCollectionView.delegate = self
   styleTypeCollectionView.dataSource = listHairTypeDataSource
  }
  
  private func render(){
    let imageType = imageStyleTypeString.map { return $0}
    listHairTypeDataSource.hairTypeString = imageType
    styleTypeCollectionView.reloadData()
  }
  

  
}

extension HairTypeStyleViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
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
