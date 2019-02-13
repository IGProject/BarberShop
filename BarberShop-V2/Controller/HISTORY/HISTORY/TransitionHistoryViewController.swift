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
    @IBOutlet weak var navigationBar: UINavigationBar!
  
  var transitionItem = [Booking]()
   var userdefault = UserDefaults.standard
  private let refreshControl = UIRefreshControl()
  
  override func viewDidAppear(_ animated: Bool) {
    setupTransitionItem()
    setupTableView()
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupNavigation()
    }
  
  func setupNavigation(){
    
    navigationItem.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: MoreTable.historyLb.rawValue, comment: "")
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.backgroundColor = COlorCustom.hexStringToUIColor(hex:"#00695C")
    UIApplication.shared.statusBarView?.backgroundColor = COlorCustom.hexStringToUIColor(hex:"#00695C")
  }
 
  
  func setupTableView(){
    historyTableView.delegate = self
    historyTableView.dataSource = self
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching History Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      historyTableView.refreshControl = refreshControl
    }else {
      historyTableView.addSubview(refreshControl)
    }
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshHistoryData), for: .valueChanged)
  }
  
  @objc private func refreshHistoryData(_ sender:Any){
    //Fetch Team Data
    self.setupTransitionItem()
  }
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
     self.dismiss(animated: true)
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
          self.refreshControl.endRefreshing()
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
