//
//  NotificationsViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

enum NotificationAlert: String {
  case countNotification
}


class NotificationsViewController: UIViewController {
    @IBOutlet weak var notificationTableView: UITableView!
  
  @IBOutlet weak var navigationBar: UINavigationBar!
  
  
  var notificationItem = NotificationAlertResponse(count: 0, results: [])
    var userdefault = UserDefaults.standard

  override func viewWillAppear(_ animated: Bool) {
       setupNotificationItem()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
      
        setNavigationBackground()
    }
  
  
  
  func setNavigationBackground(){
   navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.backgroundColor = .white
    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 0/255, green: 105/255, blue: 92/255, alpha: 1.0)
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
             self.userdefault.set(self.notificationItem.count, forKey: NotificationAlert.countNotification.rawValue)
            self.notificationTableView.reloadData()
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
  }
}

extension NotificationsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      return notificationItem.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
      
      if notificationItem.results[indexPath.row].status {
          notificationCell.configure(data: notificationItem)
        
        notificationCell.backgroundChange.backgroundColor = .brown
        
      }else {
        notificationCell.configure(data: notificationItem)
         notificationCell.backgroundChange.backgroundColor = .blue
        }
        return notificationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // let cell = tableView.cellForRow(at: indexPath)
      let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notification_id = notificationItem.results[indexPath.row].id
        let notificationEndPoint = URL(string: Domains.BaseURL + "/notification/reads_notification?")!
        let param:[String:Int] = ["notification_id": notification_id]
      getNotificationId(endpoint:notificationEndPoint,param:param, cell: notificationCell)
    
        notificationCell.selectionStyle = .none
    }
  
  func getNotificationId(endpoint:URL,param:[String:Int],cell:NotificationCell){
        Alamofire.request(endpoint, method: .get, parameters: param).responseJSON { (response) in
          switch response.result {
          case .success(_):
            
              let storyboard:UIStoryboard = UIStoryboard(storyboard: .History)
              let history = storyboard.instantiateViewController(withIdentifier: "TransitionHistoryViewController") as! TransitionHistoryViewController
              self.present(history, animated: true)
            //  cell.backgroundChange.backgroundColor = .blue
                self.notificationTableView.reloadData()
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
