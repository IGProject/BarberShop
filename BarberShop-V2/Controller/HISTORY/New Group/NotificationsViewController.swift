//
//  NotificationsViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class NotificationsViewController: UIViewController {
    @IBOutlet weak var notificationTableView: UITableView!
  
    var notificationItem = NotificationAlertResponse(count: 0, results: [])
    var userdefault = UserDefaults.standard

  
    override func viewDidLoad() {
        super.viewDidLoad()
       setupTableView()
        setupNotificationItem()
    }
  
  func setupNotificationItem(){
    let userId = self.userdefault.object(forKey: UserKeys.userId.rawValue) as? Int
    
    let notificationEndPoint = URL(string: Domains.BaseURL + "/notification/list")!
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
          
          self.notificationItem = NotificationAlertResponse(count: notificationResponse.count, results: notificationResponse.results)
          
          self.notificationTableView.reloadData()
        }catch let err{
          print("err:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
  }
  
  func setupTableView(){
    notificationTableView.delegate = self
    notificationTableView.dataSource = self
  }
}

extension NotificationsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return notificationItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
      
        notificationCell.configure(data: notificationItem)
        return notificationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
