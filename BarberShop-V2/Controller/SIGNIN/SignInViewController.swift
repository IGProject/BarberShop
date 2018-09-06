//
//  SignInViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import GoogleSignIn
import RxSwift
import RxCocoa
import Material
import Motion


class SignInViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet var signInButtonGroup: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldMaterial()
        setupClearNavigation()
    }
    func setupTextFieldMaterial(){
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
        
    }
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
    }
    
    @IBAction func SignInTappedGroup(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("user")
            break
        case 1:
            break
        case 2:
            break
        default: break
            
        }
        
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        
    }
    
}


extension SignInViewController: UITextFieldDelegate {
    
}
