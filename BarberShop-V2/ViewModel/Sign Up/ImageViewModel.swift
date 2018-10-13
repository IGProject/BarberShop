//
//  ImageViewModel.swift
//  BarberShop-V2
//
//  Created by User on 10/2/18.
//  Copyright © 2018 minea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol PhotoViewModel {
    var imagePicker: Variable<UIImage> {set get}
    var tapToChangeProfile: Observable<Bool> {get}
}

struct ImageView: PhotoViewModel {
    var imagePicker: Variable<UIImage>
    var tapToChangeProfile: Observable<Bool>
    
}
