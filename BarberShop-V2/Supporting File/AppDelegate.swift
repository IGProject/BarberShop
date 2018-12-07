//
//  AppDelegate.swift
//  BarberShop-V2
//
//  Created by User on 5/30/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Firebase configure
        FirebaseApp.configure()
      
        
        //API KEY GOOGLE MAP
        GMSServices.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
        //API KEY GOOGLE PLACE
        GMSPlacesClient.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
        
        GIDSignIn.sharedInstance().clientID = "57423766550-d80mtn23c1mmlk6n9p5bncd25e49fvcu.apps.googleusercontent.com"
        //navigation
        if #available(iOS 10.0, *) {
            UINavigationBar.appearance().barTintColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
        } else {
            // Fallback on earlier versions
        }
      
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
      
      //
      UINavigationController().navigationBar.setBackgroundImage(UIImage(), for: .default)
      UINavigationController().navigationBar.shadowImage = UIImage()
      UINavigationController().navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
      UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
      
      //
      UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.yellow], for: .selected)
      UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
      
      UITabBar.appearance().isTranslucent = false
      UITabBar.appearance().unselectedItemTintColor = UIColor.white
      UITabBar.appearance().barTintColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
      //UITabBar.appearance().backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
      UITabBar.appearance().shadowColor = UIColor.clear
        
        
        
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        //Google Sign In
        let googleAuthentication = GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        
        //Facebook Sign In
        let facebookAuthentication = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return googleAuthentication || facebookAuthentication
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

