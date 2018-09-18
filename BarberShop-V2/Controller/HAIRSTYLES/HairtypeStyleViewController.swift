//
//  HairtypeStyleViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class HairtypeStyleViewController: UIViewController {
    
    @IBOutlet weak var styleTypeCollectionView: UICollectionView!
    
    var shapeImage = [UIImage(named: "1-style"),UIImage(named: "2-style"),UIImage(named: "3-style"),UIImage(named: "4-style"),UIImage(named: "5-style"),UIImage(named: "6-style")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleTypeCollectionView.delegate = self
        styleTypeCollectionView.dataSource = self
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
    }
}

extension HairtypeStyleViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapeImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let shapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HairTypeCollectionCell", for: indexPath) as! HairTypeCollectionCell
         shapeCell.hairTypeImage.image = shapeImage[indexPath.row]
        
        shapeCell.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        shapeCell.layer.cornerRadius = 5
        shapeCell.layer.borderWidth = 0.5
        return shapeCell
    }
    
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

extension HairtypeStyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 3
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
    }
}
