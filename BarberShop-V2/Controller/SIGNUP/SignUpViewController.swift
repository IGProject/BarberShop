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
    
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var tapToChangeProfile: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldMaterial()
        setupClearNavigation()
        
        setMoveKeyboardWhenTextField()
        setTapTochangePhoto()
    }
    
    func setTapTochangePhoto(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        tapToChangeProfile.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
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
    
    //Open Image Picker
    @objc func openImagePicker(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            }else {
                print("Camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
   
    
    @IBAction func signUpToHomeTapped(_ sender: RoundButton) {
        let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(home, animated: true)
    }
    
    @IBAction func signInTapped(_ sender: RoundButton) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
