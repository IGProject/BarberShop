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
        
        emailTextField.tag = 0
        passwordTextField.tag = 1
        setupTextFieldMaterial()
        setupClearNavigation()
    }
    func setupTextFieldMaterial(){
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.textColor = UIColor.white
        
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        
        passwordTextField.visibilityIconOn = UIImage(named: "eye-64")
        passwordTextField.visibilityIconOff = UIImage(named: "hide-64")
        
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
        
    }
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func SignInTappedGroup(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if self.emailTextField.text == "minea.chem@gmail.com" && self.passwordTextField.text == "123" {
                performSegue(withIdentifier: "homeIdentifier", sender: nil)
            }
           
           
//            let storyboard:UIStoryboard = UIStoryboard(storyboard: .home)
//            let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//          navigationController?.pushViewController(home, animated: true)
            break
        case 1:
            print("Sign In with facebook")
            break
        case 2:
            print("Sign In with Google")
            break
        default: break
            
        }
        
    }
    
    @IBAction func unwindToOne(_ sender: UIStoryboardSegue){
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "homeIdentifier" {
//           if let destination = segue.destination as? HomeViewController {
//                present(destination, animated: true)
//            }
//
//        }
//    }
    
    @IBAction func registerTapped(_ sender: Any) {
        
    }
    
}


extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}
