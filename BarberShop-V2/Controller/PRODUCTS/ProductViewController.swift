//
//  ProductViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class ProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
  
  var itemsProduct = Products(length:0,results:[])
  var listProductDataSource = ListProductDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupCollectionView()
       getDataProduct()
       setupClearNavigation()
    }
  private func setupCollectionView(){
    productCollectionView.delegate = self
    productCollectionView.dataSource = listProductDataSource
  }
  private func render(){
    let itemProducts = itemsProduct.results.map { return $0}
    listProductDataSource.itemProduct.results = itemProducts
    productCollectionView.reloadData()
  }
  private func getDataProduct(){
    let productEndPoint = URL(string: Domains.BaseURL + "/product/list")!
    Alamofire.request(productEndPoint).validate().responseJSON {
      switch $0.result {
        
      case .success(_):
        let jsonData = $0.data
        do {
          let jsonDecoder = JSONDecoder()
          let productResponse = try jsonDecoder.decode(Products.self, from: jsonData!)
          self.itemsProduct = Products(length: productResponse.length, results: productResponse.results)
          self.render()
          
        }catch let error {
          print("error:\(error.localizedDescription)")
        }
        
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
  }
  
  func setupClearNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  }
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
        
         navigationController?.dismiss(animated: true)
    }
}

extension ProductViewController: UICollectionViewDelegate{
  

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

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
    }
}
