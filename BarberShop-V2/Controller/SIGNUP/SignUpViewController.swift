//
//  SignUpViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Material
import Motion

class SignUpViewController: UIViewController {
    //MARK- Outlet Connection
    @IBOutlet weak var fullnameTextField: TextField!
    @IBOutlet weak var fullnameValidation: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var phoneValidation: UILabel!
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var emailValidation: UILabel!
    
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var usernameValidation: UILabel!
    
    
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var passwordValidation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldMaterial()
        setupClearNavigation()
    }
    
    func setupTextFieldMaterial(){
        fullnameTextField.placeholderNormalColor = UIColor.white
        fullnameTextField.placeholderActiveColor = UIColor.white
        fullnameTextField.dividerNormalColor = UIColor.white
        fullnameTextField.dividerActiveColor = UIColor.white
        
        phoneNumberTextField.placeholderNormalColor = UIColor.white
        phoneNumberTextField.placeholderActiveColor = UIColor.white
        phoneNumberTextField.dividerNormalColor = UIColor.white
        phoneNumberTextField.dividerActiveColor = UIColor.white
        
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        
        usernameTextField.placeholderNormalColor = UIColor.white
        usernameTextField.placeholderActiveColor = UIColor.white
        usernameTextField.dividerNormalColor = UIColor.white
        usernameTextField.dividerActiveColor = UIColor.white
        
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    @IBAction func signUpTapped(_ sender: RoundButton) {
        
    }
}
