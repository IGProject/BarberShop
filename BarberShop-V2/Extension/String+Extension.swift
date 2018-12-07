//
//  String+Extension.swift
//  BarberShop-V2
//
//  Created by User on 11/20/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import UIKit
enum ImageFormat {
  case png
  case jpegData(CGFloat)
}

extension String {
  
  func convertImageToBase64String(format:ImageFormat,image:UIImage) -> String? {
    var imageData:Data?
    switch format {
    case .png:imageData = UIImagePNGRepresentation(image)
    case .jpegData(let compression): UIImageJPEGRepresentation(image, compression)
    }
    return imageData?.base64EncodedString()
  }
}
