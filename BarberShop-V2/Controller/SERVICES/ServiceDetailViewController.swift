//
//  ServiceDetailViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    @IBOutlet weak var title_service: UILabel!
    @IBOutlet weak var price_service: UILabel!
    @IBOutlet weak var point_service: UILabel!
    @IBOutlet weak var des_service: UILabel!
    
    
    @IBOutlet weak var serviceDetailCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceDetailCollectionView.delegate = self
        serviceDetailCollectionView.dataSource = self
    }
}

extension ServiceDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let albumCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceDetailCollectionViewCell", for: indexPath) as! ServiceDetailCollectionViewCell
        albumCell.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        albumCell.layer.cornerRadius = 5
        albumCell.layer.borderWidth = 0.5
        return albumCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
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
