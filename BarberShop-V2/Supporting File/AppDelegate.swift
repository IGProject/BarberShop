//
//  AppDelegate.swift
//  BarberShop-V2
//
//  Created by User on 5/30/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import FacebookCore
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
       setupRootViewController()
        //Firebase configure
        FirebaseApp.configure()
      // [START set_messaging_delegate]
      Messaging.messaging().delegate = self
      // [END set_messaging_delegate]
      // Register for remote notifications. This shows a permission dialog on first run, to
      // show the dialog at a more appropriate time move this registration accordingly.
      // [START register_for_notifications]
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
          if granted {
            print("allow...")
          } else {
            print("not allow...")
          }
        })
      } else {
        let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
      }
      
      application.registerForRemoteNotifications()
      
      //API KEY GOOGLE MAP
        GMSServices.provideAPIKey("AIzaSyBAJT70EGYSF-iYBwxoZHwWm1aMoVz-c9g")
     // API KEY GOOGLE PLACE
        GMSPlacesClient.provideAPIKey("AIzaSyBAJT70EGYSF-iYBwxoZHwWm1aMoVz-c9g")

       GIDSignIn.sharedInstance().clientID = "586884728274-u9gstmscu1q98sc163cvju7p2ahqodht.apps.googleusercontent.com"
//
//        GMSServices.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
//       // API KEY GOOGLE PLACE
//        GMSPlacesClient.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
//
//        GIDSignIn.sharedInstance().clientID = "57423766550-d80mtn23c1mmlk6n9p5bncd25e49fvcu.apps.googleusercontent.com"
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
      
      
      Messaging.messaging().connect { (error) in
        if error != nil {
          print("error\(error)")
        }else {
          print("connect")
        }
      }
      
        return true
    }
  
  
  // [START receive_message]
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    
    // Print full message.
    print(userInfo)
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    
    // Print full message.
    print(userInfo)
    
    completionHandler(UIBackgroundFetchResult.newData)
  }
  // [END receive_message]
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Unable to register for remote notifications: \(error.localizedDescription)")
  }
  
  // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
  // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
  // the FCM registration token.
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instange ID: \(error)")
      } else if let result = result {
        print("Remote instance ID token: \(result.token)")
      }
    }
    
    
    // With swizzling disabled you must set the APNs token here.
    // Messaging.messaging().apnsToken = deviceToken
  }

  func setupRootViewController(){
    window = UIWindow()
    let rootViewController: UIViewController
    
    if UserDefaults.standard.bool(forKey: SignInKeys.SignedIn.rawValue) != true {
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .SignIn)
      let signIn = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
       rootViewController = signIn
    } else if UserDefaults.standard.bool(forKey: SignInKeys.SignedIn.rawValue) == true {

      let storyboard:UIStoryboard = UIStoryboard(storyboard: .Home)
      let home = storyboard.instantiateViewController(withIdentifier: "CustomTabarViewController") as! MainTabarViewController
      rootViewController = home
    
    }else {
      let storyboard:UIStoryboard = UIStoryboard(storyboard: .SignUp)
      let signUp = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
      
      rootViewController = signUp
    }
    let navigationRoot = UINavigationController(rootViewController: rootViewController)
    navigationRoot.isNavigationBarHidden = true
    window?.rootViewController = navigationRoot
    window?.makeKeyAndVisible()
  }
  
  // MARK: Shortcuts
  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
   
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
      //Handle any deeplink
      // Deeplinker.checkDeepLink()
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


// [START ios_10_message_handling]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
  /// App 在前景時，推播送出時即會觸發的 delegate
  ///
  /// - Parameters:
  ///   - center: _
  ///   - notification: _
  ///   - completionHandler:
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    // 印出後台送出的推播訊息(JOSN 格式)
    let userInfo = notification.request.content.userInfo
    print("userInfo: \(userInfo)")
    
    // 可設定要收到什麼樣式的推播訊息，至少要打開 alert，不然會收不到推播訊息
    completionHandler([.badge, .sound, .alert])
  }
  
  /// App 在關掉的狀態下或 App 在背景或前景的狀態下，點擊推播訊息時所會觸發的 delegate
  ///
  /// - Parameters:
  ///   - center: _
  ///   - response: _
  ///   - completionHandler: _
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    // 印出後台送出的推播訊息(JOSN 格式)
    let userInfo = response.notification.request.content.userInfo
    print("userInfo: \(userInfo)")
    
    completionHandler()
  }
}
  
  

// [END ios_10_message_handling]

extension AppDelegate: MessagingDelegate {
  
  
  /// iOS10 含以上的版本用來接收 firebase token 的 delegate
  ///
  /// - Parameters:
  ///   - messaging: _
  ///   - fcmToken: _
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    
    print("Firebase registration token: \(fcmToken)")
    
    let dataDict:[String: String] = ["token": fcmToken]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    
    
  }
  
  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    print("Received data message: \(remoteMessage.appData)")
    print("message:\(messaging)")
  }
}
