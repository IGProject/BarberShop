//
//  NotificationsViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

enum NotificationAlert: String {
  case countNotification
}

class NotificationsViewController: UIViewController {
 
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var navigationBarNotification: UINavigationBar!
  
  private let refreshControl = UIRefreshControl()
  var notificationItem = NotificationAlertResponse(count: 0, results: [])
  var userdefault = UserDefaults.standard
  
var countNotificaton = UserDefaults.standard.value(forKey: NotificationAlert.countNotification.rawValue) as? Int
  
  override func viewWillAppear(_ animated: Bool) {
     setupNotificationItem()
     setupTableView()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBackground()
    }
  
  
  
  func setNavigationBackground(){
    navigationBarNotification.topItem?.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: NotificationTable.notificationTitle.rawValue, comment: "")
    navigationBarNotification.setBackgroundImage(UIImage(), for: .default)
    navigationBarNotification.shadowImage = UIImage()
    navigationBarNotification.backgroundColor = COlorCustom.hexStringToUIColor(hex: "#00695C")
    UIApplication.shared.statusBarView?.backgroundColor = COlorCustom.hexStringToUIColor(hex: "#00695C")
  }
  
  func setupNotificationItem(){
    let userId = self.userdefault.object(forKey: UserKeys.userId.rawValue) as? Int
    
    let notificationEndPoint = URL(string: Domains.BaseURL + "/notification/list?")!
    let notificationData = Apointment(user_id: userId!)
    let param:[String:Any] = ["user_id":notificationData.user_id]
    
    postNotification(notiEndPoint: notificationEndPoint, param: param)
  }
  
  func postNotification(notiEndPoint:URL,param:[String:Any]){
    Alamofire.request(notiEndPoint, method: .get, parameters: param).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let dataJson = $0.data!
        do{
          let notificationResponse = try JSONDecoder().decode(NotificationAlertResponse.self, from: dataJson)
          DispatchQueue.main.async {
            self.notificationItem = NotificationAlertResponse(count: notificationResponse.count, results: notificationResponse.results)
            
            self.notificationTableView.reloadData()
            self.refreshControl.endRefreshing()
          }
          
        }catch let err{
          print("err:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
  }
  
  @IBAction func BackTapped(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true)
  }
  
  func setupTableView(){
    notificationTableView.delegate = self
    notificationTableView.dataSource = self
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Notification Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      notificationTableView.refreshControl = refreshControl
    }else {
      notificationTableView.addSubview(refreshControl)
    }
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshTeamData), for: .valueChanged)
  }
  
  @objc private func refreshTeamData(_ sender:Any){
    //Fetch Team Data
    self.setupNotificationItem()
  }
}

extension NotificationsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      return notificationItem.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
      
      if notificationItem.results[indexPath.row].status {

        notificationCell.configure(data: notificationItem.results[indexPath.row])
         print("notification:\(notificationItem.count)")
      }else {
      
        print("notification change:\(notificationItem.count)")
        userdefault.set(notificationItem.count, forKey: "budges")
        
        notificationCell.configure(data: notificationItem.results[indexPath.row])
        
        notificationCell.backgroundChange.backgroundColor = COlorCustom.hexStringToUIColor(hex: "#FFFFFF")
        notificationCell.bodyLabel.textColor = .black
        notificationCell.bodyLb.textColor = .black
        notificationCell.titleLabel.textColor = .black
        notificationCell.titleLb.textColor = .black
        notificationCell.typeLb.textColor = .black
        notificationCell.typeLabel.textColor = .black
        }
        return notificationCell
    }
  
   func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    
    
    let footerView = UIView()
    return footerView
  }
  
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notification_id = notificationItem.results[indexPath.row].id
        let notificationEndPoint = URL(string: Domains.BaseURL + "/notification/reads_notification?")!
        let param:[String:Int] = ["notification_id": notification_id]
      getNotificationId(endpoint:notificationEndPoint,param:param, cell: notificationCell, indexPath: indexPath)
    
        notificationCell.selectionStyle = .none
    }
  
  func getNotificationId(endpoint:URL,param:[String:Int],cell:NotificationCell,indexPath: IndexPath){
        Alamofire.request(endpoint, method: .get, parameters: param).responseJSON { (response) in
  
          switch response.result {
          case .success(_):
          
            if self.notificationItem.results[indexPath.row].status {
              let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
              let history = storyboard.instantiateViewController(withIdentifier: "TransitionHistoryViewController") as! TransitionHistoryViewController
              self.present(history, animated: true)
              self.notificationTableView.reloadData()
              
            }else {
              
              let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
              let history = storyboard.instantiateViewController(withIdentifier: "TransitionHistoryViewController") as! TransitionHistoryViewController
              self.present(history, animated: true)
              self.notificationTableView.reloadData()
            }
            
          case .failure(let failure):
            print("failure:\(failure)")
          }
        }
        }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
