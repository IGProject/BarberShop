//
//  TransitionHistoryViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class TransitionHistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
  
   var transitionItem = [Booking]()
   var userdefault = UserDefaults.standard
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupTransitionItem()
      setupTableView()
    }
  
  func setupTableView(){
    historyTableView.delegate = self
    historyTableView.dataSource = self
  }
  
  func setupTransitionItem(){
    let userId = self.userdefault.object(forKey: UserKeys.userId.rawValue) as? Int
    let notificationEndPoint = URL(string: Domains.BaseURL + "/bookItem/tranHistory")!
    let notificationData = Apointment(user_id: userId!)
    
    let param:[String:Any] = ["user_id":notificationData.user_id]
    
    postTransition(notiEndPoint: notificationEndPoint, param: param)
  }
  
  func postTransition(notiEndPoint:URL,param:[String:Any]){
    Alamofire.request(notiEndPoint, method: .post, parameters: param).validate().responseJSON {
      switch $0.result {
      case .success(_):
        do{
          let notificationResponse = try JSONDecoder().decode(ApointmentResponse.self, from: $0.data!)
          self.transitionItem = notificationResponse.booking
          self.historyTableView.reloadData()
        }catch let err{
          print("err:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
  }
}

extension TransitionHistoryViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionItem.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
    
    historyCell.configure(data: transitionItem[indexPath.row])
    return historyCell
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
