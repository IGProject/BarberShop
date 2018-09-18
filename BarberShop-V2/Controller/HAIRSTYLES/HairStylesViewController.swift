//
//  HairStylesViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class HairStylesViewController: UIViewController {
    
    @IBOutlet weak var hairStyleCollectionView: UICollectionView!
    
    var imageHair = [UIImage(named: "1-style"),UIImage(named: "2-style"),UIImage(named: "3-style"),UIImage(named: "4-style"),UIImage(named: "5-style"),UIImage(named: "6-style")]
    var titleHair = ["ROUND","SQUARE","OBLONG","DIAMOND","TRAINGULAR","OVAL"]
    override func viewDidLoad() {
        super.viewDidLoad()
         hairStyleCollectionView.delegate = self
        hairStyleCollectionView.dataSource = self
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
    }
}

extension HairStylesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleHair.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let hairstyleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HairstyleCollectionCell", for: indexPath) as! HairstyleCollectionCell
    
        hairstyleCell.imageStyleHair.image = imageHair[indexPath.row]
        hairstyleCell.shapeNameLabel.text = titleHair[indexPath.row]
        
        hairstyleCell.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        hairstyleCell.layer.cornerRadius = 5
        hairstyleCell.layer.borderWidth = 0.5
        return hairstyleCell
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

extension HairStylesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 5
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: 183)
    }
}
