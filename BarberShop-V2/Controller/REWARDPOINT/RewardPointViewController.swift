//
//  RewardPointViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class RewardPointViewController: UIViewController {
    @IBOutlet weak var rewardCollectionView: UICollectionView!
    
    var rewardPoint = [#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point"),#imageLiteral(resourceName: "reward-point")]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
       setupCollectionView()
  
    }
  
  func setupCollectionView(){
    rewardCollectionView.delegate = self
    rewardCollectionView.dataSource = self
  }
//    func setupTitleNav() {
//        self.navigationItem.titleView = setTitle(title: "", subtitle: "")
//    }
//
//    func setTitle(title:String, subtitle:String) -> UIView {
//        let titleLabel = UILabel(frame:CGRect(x: 0, y: -2, width: 0, height: 0))
//
//        titleLabel.backgroundColor = UIColor.clear
//        titleLabel.textColor = UIColor.white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
//        titleLabel.text = title
//        titleLabel.sizeToFit()
//
//        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
//        subtitleLabel.backgroundColor = UIColor.clear
//        subtitleLabel.textColor = UIColor.white
//        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
//        subtitleLabel.text = subtitle
//        subtitleLabel.sizeToFit()
//
//        let titleView = UIView(frame: CGRect(x: 0, y:0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
//        titleView.addSubview(titleLabel)
//        titleView.addSubview(subtitleLabel)
//
//        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
//
//        if widthDiff < 0 {
//            let newX = widthDiff / 2
//            subtitleLabel.frame.origin.x = abs(newX)
//        } else {
//            let newX = widthDiff / 2
//            titleLabel.frame.origin.x = newX
//        }
//
//        return titleView
//    }

}

extension RewardPointViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewardPoint.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let rewardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardPointCollectionCell", for: indexPath) as! RewardPointCollectionCell
        rewardCell.rewardPointImageView.image = rewardPoint[indexPath.row]
        
        rewardCell.layer.borderColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1).cgColor
        rewardCell.layer.cornerRadius = 5
        rewardCell.layer.borderWidth = 0.5
        return rewardCell
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


extension RewardPointViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 5
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 5
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
    }
}
