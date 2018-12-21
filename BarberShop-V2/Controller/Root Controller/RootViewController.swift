//
//  RootViewController.swift
//  BarberShop-V2
//
//  Created by User on 12/18/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
  private var current: UIViewController
  
  var deeplink: DeeplinkType?{
    didSet{
      handleDeeplink()
    }
  }
  
   init(){
   current = SplashScreenViewController()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addChildViewController(current)
    current.view.frame = view.bounds
    view.backgroundColor = UIColor.red
    view.addSubview(current.view)
    current.didMove(toParentViewController: self)
  }
  
  func showLoginScreen(){
    let new = UINavigationController(rootViewController: SignInViewController())
    addChildViewController(new)
    new.view.frame = view.bounds
    view.addSubview(new.view)
    new.didMove(toParentViewController: self)
    
    current.willMove(toParentViewController: nil)
    current.view.removeFromSuperview()
    current.removeFromParentViewController()
    
    current = new
  }
  
  func switchToLogout(){
    let logoutViewController = MoreTableViewController()
    let logoutScreen = UINavigationController(rootViewController: logoutViewController)
    animateDismissTransition(to: logoutScreen)
  }
  
  func switchToMainScreen(){
    let tabViewController = MainTabarViewController()
    let mainScreen = tabViewController.selectedViewController
    animateFadeTransition(to: mainScreen!){ [weak self] in
      self?.handleDeeplink()
    }
    
  }
  private func animateFadeTransition(to new: UIViewController, completion:(() -> Void)? = nil){
    current.willMove(toParentViewController: nil)
    addChildViewController(new)
    transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve,.curveEaseOut], animations: {
    }){
      completed in
      self.current.removeFromParentViewController()
      new.didMove(toParentViewController: self)
      self.current = new
      completion?()
    }
  }
  
  private func animateDismissTransition(to new:UIViewController,completion:(() -> Void)? = nil) {
    let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
    current.willMove(toParentViewController: nil)
    addChildViewController(new)
    new.view.frame = initialFrame
    
    transition(from: current, to: new, duration: 0.3, options: [], animations: {
      new.view.frame = self.view.bounds
    }){ completed in
       self.current.removeFromParentViewController()
      new.didMove(toParentViewController: self)
      self.current = new
      completion?()
      
    }
  }
  
 private func handleDeeplink(){
//    if let mainTabarViewController = current as? MainTabarViewController,let deeplink = deeplink {
//      switch deeplink{
//      case .activity:
//          mainTabarViewController.selectedViewController = current
//        break
//      default:
//        break
//      }
//      self.deeplink = nil
//    }
  }

}

