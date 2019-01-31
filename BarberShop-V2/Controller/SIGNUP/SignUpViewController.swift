//
//  SignUpViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Material
import Alamofire
import Motion
import SSSpinnerButton
import Firebase

enum UserKeys: String {
  case userId
  case usernameText
  case emailText
  case phoneText
  case passwordText
  case userProfile
  case type
}

class SignUpViewController: UIViewController {
    //MARK- Outlet Connection TextField
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var rePasswordTextField: TextField!
    @IBOutlet weak var imageView: RoundedImageView!
  
    //MARK: Outlet Connection Button Upload Image
    @IBOutlet weak var tapToChangeProfile: UIButton!
    @IBOutlet weak var signupTapped:SSSpinnerButton!
  
    let userDefault = UserDefaults.standard
  
  //MARK:Properties Model
    var signUpModel: SignUp!
    var imageString: String?
  
  //MARK:Declare Object
  var registerResponse = RegisterResponse(booking: [], response: "", userToken: "", notificationCount: 0, userProfile: [], message: "")
  
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFieldMaterial()
        setupClearNavigation()
        
        setMoveKeyboardWhenTextField()
        setTapTochangePhoto()
    
    }

  
  func setMoveKeyboardWhenTextField(){
    //Listen for keyboard events
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
  }
  

    func setTapTochangePhoto(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        tapToChangeProfile.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
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
        usernameTextField.text = ""
        usernameTextField.tag = 0
        usernameTextField.textColor = UIColor.white
      
        
        phoneNumberTextField.placeholderNormalColor = UIColor.white
        phoneNumberTextField.placeholderActiveColor = UIColor.white
        phoneNumberTextField.dividerNormalColor = UIColor.white
        phoneNumberTextField.dividerActiveColor = UIColor.white
        phoneNumberTextField.text = ""
        phoneNumberTextField.tag = 1
        phoneNumberTextField.textColor = UIColor.white
      
        
        emailTextField.placeholderNormalColor = UIColor.white
        emailTextField.placeholderActiveColor = UIColor.white
        emailTextField.dividerNormalColor = UIColor.white
        emailTextField.dividerActiveColor = UIColor.white
        emailTextField.text = ""
        emailTextField.tag = 2
        emailTextField.textColor = UIColor.white
      
        
        passwordTextField.placeholderNormalColor = UIColor.white
        passwordTextField.placeholderActiveColor = UIColor.white
        passwordTextField.dividerNormalColor = UIColor.white
        passwordTextField.dividerActiveColor = UIColor.white
        passwordTextField.text = ""
        passwordTextField.tag = 3
        passwordTextField.visibilityIconOn = UIImage(named: "eye-64")
        passwordTextField.visibilityIconOff = UIImage(named: "hide-64")
        passwordTextField.textColor = UIColor.white
      
        
        rePasswordTextField.placeholderNormalColor = UIColor.white
        rePasswordTextField.placeholderActiveColor = UIColor.white
        rePasswordTextField.dividerNormalColor = UIColor.white
        rePasswordTextField.dividerActiveColor = UIColor.white
        rePasswordTextField.text = ""
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
        imagePickerController.allowsEditing = true
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
  
  
    @IBAction func signUpTapped(_ sender: SSSpinnerButton) {
      
      self.createObjectForPost(sender: sender)
    }
      private func createObjectForPost(sender: SSSpinnerButton){
        //1.Create model Object
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instange ID: \(error)")
          } else if let result = result {
    
            if self.usernameTextField.text != "" && self.passwordTextField.text != "" && self.phoneNumberTextField.text != "" && self.emailTextField.text != "" && self.imageView.image != nil && self.imageString != "" {
             //MARK:Model
              self.signUpModel = SignUp(username: self.usernameTextField.text!, email: self.emailTextField.text!, phone: self.phoneNumberTextField.text!,
              token: result.token, password: self.passwordTextField.text!,
              base64_image:self.imageString ?? "", type: .email)
              
              //2.MARK: create UserEndPoint
              let userEndPoint = URL(string: Domains.BaseURL + "/user/register")
              
              //3.MARK: Create Param for post Resgister
              let param:[String:Any] = [  "username":self.signUpModel.username,
                                          "email":self.signUpModel.email,
                                          "token":self.signUpModel.token,
                                          "phone":self.signUpModel.phone,
                                          "base64_image":self.signUpModel.base64_image!,
                                          "password":self.signUpModel.password,
                                          "type":self.signUpModel.type
              ]
              //4.MARK:Access service api with Alamofire
              self.registerUser(endPoint: userEndPoint!, param: param,sender:sender)
  
            }else if self.usernameTextField.text == ""{
              print("please enter usename")
              self.usernameTextField.becomeFirstResponder()
              
            }else if self.phoneNumberTextField.text == "" {
              print("please enter phone number")
              self.phoneNumberTextField.becomeFirstResponder()
              
            }else if self.emailTextField.text == ""{
              print("please enter email ")
              self.emailTextField.becomeFirstResponder()
              
            }else if self.passwordTextField.text == "" {
              print("please enter password")
              self.passwordTextField.becomeFirstResponder()
              
            }else if self.rePasswordTextField.text == "" {
              print("please enter confirm password")
              self.rePasswordTextField.becomeFirstResponder()
            }else if self.imageString == nil {
              print("please upload image")
              self.imageView.becomeFirstResponder()
            }
          }
        }
       
      }
  
   private func registerUser(endPoint:URL,param:Parameters,sender:SSSpinnerButton){
    Alamofire.request(endPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      switch response.result {
      case .success(_):
            let dataJson = response.data
            do{
              
              let jsonDecoder = JSONDecoder()
              let registerResponse =  try jsonDecoder.decode(RegisterResponse.self, from: dataJson!)
      
              //MARK: RegisterResponse
              
              self.registerResponse = RegisterResponse(booking: registerResponse.booking, response: registerResponse.response, userToken: registerResponse.userToken, notificationCount: registerResponse.notificationCount, userProfile: registerResponse.userProfile, message: registerResponse.message)
              
            }catch let error {
              print("error:\(error.localizedDescription)")
            }
              //MARK: UserDefault
            if self.registerResponse.response == "false"{
              let alertRegister = UIAlertController(title: "Alert Message", message: self.registerResponse.message, preferredStyle: .alert)
              alertRegister.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
                self.usernameTextField.becomeFirstResponder()
              }))
              
              self.present(alertRegister, animated: true)
             
            }else {
              self.userDefault.set(self.registerResponse.userProfile[0].profileImage, forKey: UserKeys.userProfile.rawValue)
              
              self.userDefault.set(self.registerResponse.userProfile[0].username, forKey: UserKeys.usernameText.rawValue)
              
              self.userDefault.set(self.registerResponse.userProfile[0].id, forKey: UserKeys.userId.rawValue)
              
              
              let alertMessage = UIAlertController(title: "Success", message: self.registerResponse.message, preferredStyle: .alert)
              let alertAction = UIAlertAction(title: "Wow", style: .default, handler: { (action) in
                
                self.gotoHomeScreen(sender: sender)
                
              })
              
              alertMessage.addAction(alertAction)
              self.present(alertMessage, animated: true)
            }
            
              
            
        break
      case .failure(let error):
        print(error.localizedDescription)
        break
      }
    }
  }


  //MARK: Validation TextField
  private func setupValidateTextField(sender:SSSpinnerButton){
    let response = Validation.shared.validate(values: (ValidationType.alphabeticString,usernameTextField.text ?? ""),(ValidationType.phoneNo,phoneNumberTextField.text ?? ""),(ValidationType.email,emailTextField.text ?? ""),
    (ValidationType.password,passwordTextField.text ?? ""),
    (ValidationType.password,rePasswordTextField.text ?? ""))
    
    switch response {
    case .success:
      self.gotoHomeScreen(sender: sender)
      break
    case .failure(_, let message):
       failAlertMessage(valid: message)
    }
  }
  
  private func gotoHomeScreen(sender:SSSpinnerButton) {
    
    sender.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1), spinnerSize: 20, complete: nil)
    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
      
       sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: nil)
      
      let storyboard:UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
      let home = storyboard.instantiateViewController(withIdentifier: "CustomTabarViewController") as! MainTabarViewController
      self.present(home, animated: true)
      
       self.userDefault.set(true, forKey: SignInKeys.SignedIn.rawValue)
      
    }
   
  }
  
 private func failAlertMessage(valid: AlertMessages){
   let alertMessage = UIAlertController(title: "AlertMessage", message: valid.rawValue, preferredStyle: .alert)
   let OKAction = UIAlertAction(title: "OK", style: .default)
   alertMessage.addAction(OKAction)
   self.present(alertMessage, animated: true)
  }
  
  
  
  
    @IBAction func signInTapped(_ sender: RoundButton) {
      navigationController?.dismiss(animated: true)
    }
}


extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      //Edit
      guard let imageEdit = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
      imageView.image = imageEdit
      
      //Origin
      guard let imageOrigin = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
       imageView.image = imageOrigin
      
      //Crop Image
      let resizeImage = imageOrigin.crop(toWidth: 150.0, toHeight: 150.0)
    
    // convert image to Data
      guard let imageData:Data = UIImageJPEGRepresentation( resizeImage!, 1.0) else { return }
    
      // convert data to String
      let base64String = imageData.base64EncodedString()
      
      imageString = base64String
      
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
