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
import Material
import Motion
import SSSpinnerButton


class SignInViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
   
    
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signInButtonGroup: SSSpinnerButton!
    
     private let readPermissions: [ReadPermission] = [ .publicProfile, .email, .userFriends, .custom("user_posts") ]
    var alertController: UIAlertController?
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
    
    @IBAction func SignInTappedGroup(_ sender: SSSpinnerButton) {
        let arr: [SpinnerType] = [SpinnerType.ballRotateChase,SpinnerType.ballRotateChase,SpinnerType.ballRotateChase]
        
        //MARK: Start Animating
        sender.startAnimate(spinnerType: arr[sender.tag], spinnercolor: UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1), spinnerSize: 20, complete: nil)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
            
            switch sender.tag {
            case 0: //facebook
                // MARK: Stop Animating with completion type and back to default
                // MARK: completion type is fail
            sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: {
                     let loginManager = LoginManager()
                loginManager.logIn(readPermissions: self.readPermissions, viewController: self, completion: self.didReceiveFacebookLoginResult)
                })
                return
            case 1: //google
               
                // MARK: Stop Animating with completion type and back to default
                // MARK: completion type is fail
            sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: {
                    GIDSignIn.sharedInstance()?.signIn()
                })
            case 2: //Sign In Gmail
               sender.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .none, backToDefaults: true, complete: {
                
                let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
                let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(home, animated: true)
                })
            default:
                print("nothing")
                break
                
            }
        }
    
    }
    
    private  func didReceiveFacebookLoginResult(loginResult: LoginResult){
        switch loginResult {
        case .success:
            didLoginWithFacebook()
        case .cancelled:
            alertController = UIAlertController(title: "Login Cancelled", message: "User cancelled login", preferredStyle: .alert)
            
        case .failed(let error):
            
            alertController = UIAlertController(title: "Login Fail", message: "User failed with error\(error)", preferredStyle: .alert)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
           // let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let picture = user.profile.imageURL(withDimension: 150)
            
            print("\(String(describing: idToken)),\n\(String(describing: fullName)),\n \(String(describing: givenName)), \n \(String(describing: familyName)) \(String(describing: email)),\n\(String(describing: picture))")
        }
    }
    
    func didLoginWithFacebook(){
        
        //self.didLogin(method: "Facebook")
        //successful log in with Facebook
//        if let accessToken = AccessToken.current {
//            
//        }
    }
    
 
    
    
    func googleLogin(){
        
    }
    
    func gmailLogin(){
        
    }
    
//    @IBAction func unwindToOne(_ sender: UIStoryboardSegue){
//
//    }
    
    @IBAction func registerTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "goToSignUp", sender: self)
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
