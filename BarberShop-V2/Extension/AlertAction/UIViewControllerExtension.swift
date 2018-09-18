//
//  UIViewControllerExtension.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

protocol SingleButtonDialogPresenter {
    func presentSingleButtonDialog(alert: SingleButtonAlert)
}

extension SingleButtonDialogPresenter where Self: UIViewController {
    func presentSingleButtonDialog(alert: SingleButtonAlert){
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alert.action.buttonTitle, style: .default, handler: { _ in alert.action.handler?() }))
        present(alertController, animated: true, completion: nil)
    }
}
