//
//  AppDelegate.swift
//  BarberShop-V2
//
//  Created by User on 5/30/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import UserNotifications
import FirebaseMessaging

import FacebookCore
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
  
  public var notification: Int?
  public var mNotCallback: NotificationListener?
  public var mDataCallback: GetDataNotificationListener?
  
  var window: UIWindow?
  let gcmMessageIDKey = "gcm.message_id"
  let notifications = Notifications()
  var notificationAlert: UNNotification?
  
  var countBudge = UserDefaults.standard.value(forKey: "budge") as? Int ?? 0
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    
    setupRootViewController()
    
    //Firebase configure
    FirebaseApp.configure()
    // [START set_messaging_delegate]
    Messaging.messaging().delegate = self
    Messaging.messaging().shouldEstablishDirectChannel = true
    Messaging.messaging().useMessagingDelegateForDirectChannel = true
    
    // [END set_messaging_delegate]
    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    
    //Notification Local
    
       application.applicationIconBadgeNumber = countBudge
    
    if #available(iOS 10.0, *) {
      
      //        // For iOS 10 display notification (sent via APNS)
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
    
   //let countNotification = UserDefaults.standard.value(forKey:"budges") as? Int ?? 0
    application.registerForRemoteNotifications()
  //  application.applicationIconBadgeNumber = countNotification
    
    //API KEY GOOGLE MAP
    GMSServices.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
    // API KEY GOOGLE PLACE
    GMSPlacesClient.provideAPIKey("AIzaSyDytfVVdSQfVN32VFBqpHPKAwa0cL_rx_o")
    
    GIDSignIn.sharedInstance().clientID = "586884728274-u9gstmscu1q98sc163cvju7p2ahqodht.apps.googleusercontent.com"
    
    //navigation
    if #available(iOS 10.0, *) {
      UINavigationBar.appearance().barTintColor =  UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
    } else {
      // Fallback on earlier versions
    }
    
   UIApplication.shared.statusBarStyle = .lightContent
    UINavigationBar.appearance().tintColor = UIColor.white
    let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = textAttributes
    // UIApplication.shared.applicationIconBadgeNumber = 0
    
    //
    UINavigationController().navigationBar.setBackgroundImage(UIImage(), for: .default)
    UINavigationController().navigationBar.shadowImage = UIImage()
    UINavigationController().navigationBar.backgroundColor = .white
    UIApplication.shared.statusBarView?.backgroundColor =  UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
    
    //
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .selected)
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: COlorCustom.hexStringToUIColor(hex:"#00695C")], for: .normal)
    
    UITabBar.appearance().isTranslucent = false
  
    UITabBar.appearance().unselectedItemTintColor = COlorCustom.hexStringToUIColor(hex:"#616161")
    UITabBar.appearance().tintColor = COlorCustom.hexStringToUIColor(hex: "#00695C")
    UITabBar.appearance().barTintColor = UIColor.white
    
    //UITabBar.appearance().backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
    UITabBar.appearance().shadowColor = UIColor.clear
    
    return true
  }
  
  
  
  
  // [START receive_message]
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    
     getNotification()
    application.applicationIconBadgeNumber = countBudge
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    
  }
  
  //when Recieve Message From Server or Firebase
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
  
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    
      getNotification()
      application.applicationIconBadgeNumber = countBudge
    
    print("message_id:\(String(describing: userInfo[gcmMessageIDKey]))")
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID didReceiveRemoteNotification: \(messageID)")
    }
    print("data payload:\(String(describing: userInfo["aps"]))")
    
    
    //postNotification(notiEndPoint: url, param: ["user_id":userId!])
    // Print full message.
    
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
    
    application.applicationIconBadgeNumber = countBudge
    
    print("deviceTokenString: \(deviceToken)")
    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instange ID: \(error)")
      } else if let result = result {
        print("Remote instance ID token: \(result.token)")
      }
    }
    
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
  
  
  func getNotification(){
    let userId = UserDefaults.standard.value(forKey: UserKeys.userId.rawValue) as? Int
    guard (userId != nil) else {return}
    let notificationEndPoint = URL(string: Domains.BaseURL + "/notification/list?")!
    let notificationData = Apointment(user_id: userId!)
    let param:[String:Any] = ["user_id":notificationData.user_id]
    
    Alamofire.request(notificationEndPoint, method: .get, parameters: param).responseJSON { (response) in
      switch response.result {
      case .success(_):
        let jsonData = response.data!
        
        do{
          let responseNotification = try! JSONDecoder().decode(NotificationAlertResponse.self, from: jsonData)
          let getResponse = NotificationAlertResponse(count: responseNotification.count, results: responseNotification.results)
          
          if self.mNotCallback != nil {
            self.mNotCallback?.onNotificationLoad(value: getResponse.count)
          }
        }
      case .failure(let error):
        print("failure:\(error.localizedDescription)")
      }
    }
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
     getNotification()
    application.applicationIconBadgeNumber = countBudge
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
     getNotification()
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    getNotification()
    application.applicationIconBadgeNumber = countBudge
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    //Open Screen
     getNotification()
     application.applicationIconBadgeNumber = countBudge
    //Handle any deeplink

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
     getNotification()
    application.applicationIconBadgeNumber = countBudge
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}


// [START ios_10_message_handling]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  
  
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
   
   getNotification()
    

    //
    
    let userInfo = notification.request.content.userInfo
    
    
    print("userInfo:\(String(describing: userInfo[gcmMessageIDKey]))")
    //print("aps\(userInfo["sps"])")
    completionHandler([.badge, .sound, .alert])
  }
  
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID didReceive response: \(messageID)")
    }
    
   
    // Print full message.
    print(userInfo)
    
    
    completionHandler()
  }
  
  
}

// [END ios_10_message_handling]

extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    
    print("Firebase registration token: \(fcmToken)")
    
    let dataDict:[String: String] = ["token": fcmToken]
    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
  }
  
  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    
    print("bookingTime:\(String(describing: remoteMessage.appData["book_time"]))")
    print("sound:\(String(describing: remoteMessage.appData["sound"]))")
    print("body:\(String(describing: remoteMessage.appData["body"]))")
    print("status:\(String(describing: remoteMessage.appData["status"]))")
    print("message:\(messaging)")
    
  }
  
  
}
