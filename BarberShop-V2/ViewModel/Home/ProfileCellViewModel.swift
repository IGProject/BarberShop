//
//  ProfileCellViewModel.swift
//  BarberShop-V2
//
//  Created by User on 9/17/18.
//  Copyright © 2018 minea. All rights reserved.
//

protocol ProfileCellViewModel {
    var profileItem: ProfileModel{get}
    var profileImage: String {get}
    var userName: String {get}
    var emailText: String {get}
}

extension ProfileModel: ProfileCellViewModel {
    var profileItem: ProfileModel {
        return self
    }
    var profileImage: String {
      return image
    }
    
    var userName: String {
        return profileItem.userName
    }
    
    var emailText: String {
        return profileItem.email
    }
    
   
    
}


