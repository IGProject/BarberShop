//
//  HomeCollectionViewCell.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell{

    @IBOutlet weak var iconBarberShop: UIImageView!
    @IBOutlet weak var titleBarberShop: UILabel!
    
    func setup(vm: HomeViewModel<HomeModel>){
        self.iconBarberShop.image = vm.value.imageName
        self.titleBarberShop.text = vm.value.name
    }

}
