//
//  RewardPointViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class RewardPointViewController: UIViewController {
    @IBOutlet weak var rewardCollectionView: UICollectionView!
    
  @IBOutlet weak var pointLabel: UILabel!
  
  var rewardPoint = [UIImage]()
  var point:Int?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
      setupCollectionView()
     getPointAPI()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
      getPointAPI()
    }
  
  func getPointAPI(){
   let userId = UserDefaults.standard.value(forKey: UserKeys.userId.rawValue) as? Int
    let rewardEndPoint = URL(string: Domains.BaseURL + "/user/getPoint?")!
    let param:[String:Any] = ["id":userId!]
    
    Alamofire.request(rewardEndPoint, method: .get, parameters: param).responseJSON { (response) in
      
      switch response.result {
      case .success(_):
        let jsonData = response.data
        do {
          let responsePoint = try! JSONDecoder().decode(PointResponse.self, from: jsonData!)
    
          self.point = responsePoint.point ?? 0
          self.rewardCollectionView.reloadData()
          
          self.pointLabel.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: Loading.pointTitleKey.rawValue, comment: "")) \(String(describing: self.point!))"
        }catch let err {
          print("err:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
    
  }
  
  func setupCollectionView(){
    rewardCollectionView.delegate = self
    rewardCollectionView.dataSource = self
  }
}

extension RewardPointViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.point ?? 0 < 0 ? 0: self.point ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let rewardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardPointCollectionCell", for: indexPath) as! RewardPointCollectionCell
      
    
  
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
