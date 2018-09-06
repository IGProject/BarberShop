//
//  BarbersDataSource.swift
//  BarberShop-V2
//
//  Created by User on 6/22/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit

class GenericBarbersDataSource<B>:NSObject{
    var data:DynamicBarbersValue<[B]> = DynamicBarbersValue([])
}

class BarbersDataSource: GenericBarbersDataSource<TeamDetails>,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let barbersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! OurTeamCollectionViewCell
        
        let arrayOfOurTeam = self.data.value[indexPath.row]
        barbersCell.phoneTeam.text = arrayOfOurTeam.phone
        barbersCell.usernameTeam.text = arrayOfOurTeam.username
        //barbersCell.imageOurTeam.image = arrayOfOurTeam.team_image
        return barbersCell
    }
    
    
}
