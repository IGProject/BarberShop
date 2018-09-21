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
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var usernameValidation: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var phoneValidation: UILabel!
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var emailValidation: UILabel!
    
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var passwordValidation: UILabel!
    
    
    @IBOutlet weak var rePasswordTextField: TextField!
    
    @IBOutlet weak var rePasswordValidation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldMaterial()
        setupClearNavigation()
        
        setMoveKeyboardWhenTextField()
    }
    
    func setMoveKeyboardWhenTextField(){
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        //Stop listening for keyboard hide/show event
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            
            view.frame.origin.y = -keyboardRect.height/2
        }else {
            view.frame.origin.y = 0
        }
        
    }
    func setupTextFieldMaterial(){
        usernameTextField.placeholderNormalColor = UIColor.white
        usernameTextField.placeholderActiveColor = UIColor.white
        usernameTextField.dividerNormalColor = UIColor.white
        usernameTextField.dividerActiveColor = UIColor.white
        usernameTextField.tag = 0
        usernameTextField.textColor = UIColor.white
        
        phoneNumberTextField.placeholderNormalColor = UIColor.white
        phoneNumberTextField.placeholderActiveColor = UIColor.white
        phoneNumberTextField.dividerNormalColor = UIColor.white
        phoneNumberTextField.dividerActiveColor = UIColor.white
        phoneNumberTextField.tag = 1
        phoneNumberTextField.textColor = UIColor.white
        
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        emailTextField.tag = 2
        emailTextField.textColor = UIColor.white
        
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
        passwordTextField.tag = 3
        passwordTextField.visibilityIconOn = UIImage(named: "eye-64")
        passwordTextField.visibilityIconOff = UIImage(named: "hide-64")
        passwordTextField.textColor = UIColor.white
        
        rePasswordTextField.placeholderNormalColor = UIColor.white
        rePasswordTextField.placeholderActiveColor = UIColor.white
        rePasswordTextField.dividerNormalColor = UIColor.white
        rePasswordTextField.dividerActiveColor = UIColor.white
        rePasswordTextField.tag = 4
        rePasswordTextField.visibilityIconOn = UIImage(named: "eye-64")
        rePasswordTextField.visibilityIconOff = UIImage(named: "hide-64")
        rePasswordTextField.textColor = UIColor.white
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    @IBAction func signUpTapped(_ sender: RoundButton) {
        
    }
    
    @IBAction func signInTapped(_ sender: RoundButton) {
        performSegue(withIdentifier: "", sender: self)
    }
}

extension SignUpViewController: UITextFieldDelegate {

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
