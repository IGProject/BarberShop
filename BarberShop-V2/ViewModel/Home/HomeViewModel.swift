//
//  HomeViewModel.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit



class  GenericHomeDataSource<H>: NSObject {
    var dataHome:HomeViewModel<[H]> = HomeViewModel([]) //initialize generic home model
}
class HomeDataSource: GenericHomeDataSource<HomeModel>,UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataHome.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeIdentifier", for: indexPath) as! HomeCollectionViewCell
       // homeCell.setup(vm: HomeViewModel<HomeModel>)
        return homeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("0")
            break
        case 1:
            print("0")
            break
        case 2:
            print("0")
        break
        case 3:
            print("0")
        break
        case 4:
            print("0")
        break
        case 5:
            print("0")
            break
        default:
            print("nothing")
            break
        }
    }
}

