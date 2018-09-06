//
//  HomeViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 38/255.0, green: 103/255.0, blue: 164/255.0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 38/255.0, green: 103/255.0, blue: 164/255.0, alpha: 1)
    }
}

extension HomeViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
}

////slide bar
//extension HomeViewController: SidebarViewDelegate {
//    func sidebarDidSelectRow(row: Row) {
//        blackScreen.isHidden=true
//        blackScreen.frame=self.view.bounds
//        UIView.animate(withDuration: 0.3) {
//            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
//        }
//        switch row {
//        case .editProfile:
//            break
//        case .home:
//            let storyBoard: UIStoryboard = UIStoryboard(storyboard: .home)
//            let home = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            self.navigationController?.pushViewController(home, animated: false)
//            break
//        case .my_appointments:
//            print("my_appointments")
//            break
//        case .reward_points:
//            print("reward_points")
//            break
//        case .notification:
//            print("notification")
//            break
//        case .setting:
//            print("setting")
//            break
//        case .transaction_history:
//            print("transaction_history")
//            break
//        case .about_us:
//            print("about_us")
//            break
//        case .signOut:
////            UserDefaults.standard.set(false, forKey: "ISUSERLOGINNED")
////            self.navigationController?.popViewController(animated: true)
//
//            print("logout")
//            break
//        default:
//            print("default")
//            break
//        }
//    }
//}
//
