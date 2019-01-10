//
//  SignInViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import Firebase
import Alamofire
import Material
import Motion
import SSSpinnerButton

enum SignInKeys: String{
  case SignedIn
}
class SignInViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
   
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
  
  //MARK:create Object
  var signInResponse = SignInResponse(booking: [], response: "", userToken: "", userProfile:[], notificationCount: 0)
  
  var userSocailRespone = UserSocialResponse(response: false, notificationCount: 0, userData:UserData(id: 0, userID: "", username: "", image: "", token: "", email: "", type: 0, userToken: ""))
  
    private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]
  
  //MARK:create propteries
    var alertController: UIAlertController?
  
  var userDefault = UserDefaults.standard
   var signIn:SignInEmail!
   var facebookUser:UserSocial!
   var googleUser:UserSocial!
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
        emailTextField.tag = 0
        passwordTextField.tag = 1
        setupTextFieldMaterial()
        setupClearNavigation()
        initGoogleSignIn()
      
    }
  
    func initGoogleSignIn(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
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
  
//  SignIn Button Group
    @IBAction func SignInTappedGroup(_ sender: SSSpinnerButton) {
        let arr: [SpinnerType] = [SpinnerType.ballRotateChase,SpinnerType.ballRotateChase,SpinnerType.ballRotateChase]
        
        //MARK: Start Animating
        sender.startAnimate(spinnerType: arr[sender.tag], spinnercolor: UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1), spinnerSize: 20, complete: nil)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            
            switch sender.tag {
            case 0:
              //facebook
                sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: nil)
                let loginManager = LoginManager()
                
                loginManager.logIn(readPermissions: self.readPermissions, viewController: self, completion: self.didReceiveFacebookLoginResult)
                return
            case 1:
              //google
               sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: nil)
                   GIDSignIn.sharedInstance()!.signIn()
               return
            case 2:
              //Sign In Gmail
                sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: nil)
                   self.signInEmail()
                return
            default:
                print("nothing")
                break
            }
        }
    }
  
//  Function SignInEmail
  private func  signInEmail(){
    
    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instange ID: \(error)")
      } else if let result = result {
        
          self.signIn = SignInEmail(username: self.emailTextField.text!, password: self.passwordTextField.text!, token: result.token)
        
        if self.emailTextField.text != "" && self.passwordTextField.text != "" {
          
          let loginEndPoint = URL(string: Domains.BaseURL + "/user/login")!
          
          let param:[String:Any] = ["username":self.signIn.username,
                                    "pass":self.signIn.password,
                                    "token": self.signIn.token]

          self.postLoginEmail(endpoint:loginEndPoint,param:param)
          
        }else if (self.emailTextField.text?.isEmpty)! && (self.passwordTextField.text?.isEmpty)! {
             AlertController.showAlertWhenTextEmpty(on: self, with: "Empty text", message: "Please Enter username and password")
    
            self.emailTextField.resignFirstResponder()
  
        }
      }
    }
    
    
   
  }
  
  private func  postLoginEmail(endpoint:URL,param:[String:Any]){
    Alamofire.request(endpoint, method: .post, parameters: param).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do{
          let jsonDecoder = JSONDecoder()
          let loginResponse = try jsonDecoder.decode(SignInResponse.self, from: jsonData!)
           self.signInResponse = SignInResponse(booking: loginResponse.booking, response: loginResponse.response, userToken: loginResponse.userToken, userProfile: loginResponse.userProfile, notificationCount: loginResponse.notificationCount)
          

          self.userDefault.set(self.signInResponse.userProfile[0].profileImage, forKey: UserKeys.userProfile.rawValue)
          self.userDefault.set(self.signInResponse.userProfile[0].username, forKey: UserKeys.usernameText.rawValue)
          self.userDefault.set(self.signInResponse.userProfile[0].id, forKey: UserKeys.userId.rawValue)
          
    
          let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
          let home = storyboard.instantiateViewController(withIdentifier: "CustomTabarViewController") as! MainTabarViewController
          self.navigationController?.present(home, animated: true)
          
          self.userDefault.set(true, forKey: SignInKeys.SignedIn.rawValue)
         
        }catch let err {
          print("error:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
  }
  
//    MARK: LoginResult /////////////////////////////////////////////
    private func didReceiveFacebookLoginResult(loginResult: LoginResult){
      switch loginResult{
      case .success(_,_,let token):
        didLoginWithFacebook(token: token)
        break
      case .cancelled:
        print("cancelled")
      case .failed(_):
        print("failed")
      }
    }
  
  func didLoginWithFacebook(token:AccessToken){
        let connection = GraphRequestConnection()
    connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"id,name,email"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: GraphAPIVersion.defaultVersion)){
       response,result in
      switch result {
        
      case .success(let response):
        let imgURLString = URL(string: "http://graph.facebook.com/\(response.dictionaryValue!["id"] as! String)"  + "/picture?type=large")!
        
        
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instange ID: \(error)")
          } else if let result = result {
            self.facebookUser = UserSocial(username: response.dictionaryValue!["name"]! as! String, email: response.dictionaryValue!["email"]! as! String, token: result.token, user_id: response.dictionaryValue!["id"]! as! String, image: imgURLString.absoluteString , type: .facebook)

            let param:[String:Any] = [
           
              "username":self.facebookUser.username,
              "email":self.facebookUser.email,
              "token":self.facebookUser.token,
              "user_id":self.facebookUser.user_id,
              "image":self.facebookUser.image,
              "type": self.facebookUser.type
            ]
            
            let userFacebookEndPoint = URL(string: Domains.BaseURL + "/user/socialRegister")!
            self.postUserFacebook(endPoint:userFacebookEndPoint,param:param)
            
          }
        }
        break
      case .failed(let error):
        print("error fetching loggedin user profile ==\(error.localizedDescription)")
      }
    }
    connection.start()
    }
  
  func postUserFacebook(endPoint:URL,param:[String:Any]){
    Alamofire.request(endPoint, method: .post, parameters: param).validate().responseJSON(completionHandler: {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do {
          let userFbResponse = try JSONDecoder().decode(UserSocialResponse.self, from: jsonData!)
          print("userFb:\(userFbResponse)")
          
          self.userSocailRespone = UserSocialResponse(response: userFbResponse.response, notificationCount: userFbResponse.notificationCount, userData: userFbResponse.userData)
          
          //MARK: UserDefault
          self.userDefault.set(self.userSocailRespone.userData.image, forKey: UserKeys.userProfile.rawValue)
          
         self.userDefault.set(self.userSocailRespone.userData.username, forKey: UserKeys.usernameText.rawValue)

         self.userDefault.set(Int(self.userSocailRespone.userData.id), forKey: UserKeys.userId.rawValue)
          
          self.userDefault.set(self.userSocailRespone.userData.type, forKey: UserKeys.type.rawValue)
          
          let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
          let home = storyboard.instantiateViewController(withIdentifier: "CustomTabarViewController") as! MainTabarViewController
          self.navigationController?.present(home, animated: true)

          self.userDefault.set(true, forKey: SignInKeys.SignedIn.rawValue)
          
        }catch let err {
          print("err:\(err)")
        }
      case .failure(_):
        break
      }
    })
  }

  //SignIn With Google ///////////////////////////////
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    
    if let error = error {
      print("\(error.localizedDescription)")
    } else {

      // Perform any operations on signed in user here.
      let urlImage = user!.profile!.imageURL(withDimension: 150)!
     
      InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
          print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
       self.googleUser = UserSocial(username: user!.profile!.name!, email: user!.profile!.email!, token: result.token, user_id:user!.userID!, image: urlImage.absoluteString, type: .google)
          
          let param:[String:Any] = [
            "username":self.googleUser.username,
            "email":self.googleUser.email,
            "token":self.googleUser.token,
            "user_id":self.googleUser.user_id,
            "image":self.googleUser.image,
            "type":self.googleUser.type
          ]
          
          let userGoogleEndPoint = URL(string: Domains.BaseURL + "/user/socialRegister")!
          self.postUserGoogle(endPoint:userGoogleEndPoint,param:param)
          
        }
      }
      
    }
  }
  
  private func postUserGoogle(endPoint:URL,param:[String:Any]){
    Alamofire.request(endPoint, method: .post, parameters: param).validate().responseJSON { response in
      switch response.result {
      case .success(_):
        
        let jsonData = response.data!
        do{
          let googleResponse = try JSONDecoder().decode(UserSocialResponse.self, from: jsonData)
         
          self.userSocailRespone = UserSocialResponse(response: googleResponse.response, notificationCount: googleResponse.notificationCount, userData: googleResponse.userData)
          
      
          //MARK: UserDefault
          self.userDefault.set(self.userSocailRespone.userData.image, forKey: UserKeys.userProfile.rawValue)
          
          self.userDefault.set(self.userSocailRespone.userData.username, forKey: UserKeys.usernameText.rawValue)
          
          self.userDefault.set(self.userSocailRespone.userData.id, forKey: UserKeys.userId.rawValue)
          
          self.userDefault.set(self.userSocailRespone.userData.type, forKey: UserKeys.type.rawValue)
          let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
          let home = storyboard.instantiateViewController(withIdentifier: "CustomTabarViewController") as! MainTabarViewController
          self.navigationController?.present(home, animated: true)

          self.userDefault.set(true, forKey: SignInKeys.SignedIn.rawValue)
          
        }catch let err {
          print("err:\(err.localizedDescription)")
        }
        
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
        
      }
    }
  }
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
    @IBAction func registerTapped(_ sender: Any) {
      
      let storyboard:UIStoryboard = UIStoryboard(storyboard:.SignUp)
      let signUp = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
      navigationController?.present(signUp, animated: true)
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
