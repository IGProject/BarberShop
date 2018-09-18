//
//  ContentCellViewModel.swift
//  BarberShop-V2
//
//  Created by User on 9/17/18.
//  Copyright © 2018 minea. All rights reserved.
//

protocol ContentCellViewModel {
    var contentItem: ContentModel {get}
    var imageView: String {get}
    var content: String {get}
}

extension ContentModel: ContentCellViewModel {
    var contentItem: ContentModel {
        return self
    }
    
    var imageView: String {
        return contentItem.image
    }
    
    var content: String {
        return contentItem.contentText
    }
    
    
}
