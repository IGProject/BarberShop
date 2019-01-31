//
//  SettingTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import UserNotifications

enum SettingKeys: String{
  case apointmentSwitch
  case remainderSwitch
  case languagueSwitch
  case isOn
  case changeBefore
  case changeLater
  case saveSetting
  case saveLanguage
  case changeLanguages
  case khmer
  case notifications
}


class SettingTableViewController: UITableViewController,UNUserNotificationCenterDelegate {
  
  
  @IBOutlet weak var navTitle: UINavigationItem!
  
  @IBOutlet weak var apointmentTitleLabel: UILabel!
  @IBOutlet weak var remainderTitleLabel: UILabel!
  @IBOutlet weak var beforeLabel: UILabel!
  @IBOutlet weak var minuteBeforeLabel: UILabel!
  @IBOutlet weak var laterLabel: UILabel!
  @IBOutlet weak var dayLatersLabel: UILabel!
  @IBOutlet weak var notificationLabel: UILabel!
  
  
  
  @IBOutlet weak var beforeSlider: UISlider!
  @IBOutlet weak var laterSlider: UISlider!
  
  @IBOutlet weak var apointmentSwitch: UISwitch!
  @IBOutlet weak var remainderSwitch: UISwitch!
  @IBOutlet weak var languageSwitch: UISwitch!
  @IBOutlet weak var notificationAlertSwitch: UISwitch!
  
  var switchState = false
  
  
  
  @IBOutlet weak var englishBtn: UIButton!
  @IBOutlet weak var khmerBtn: UIButton!
  
  
  
  var userDefault = UserDefaults.standard
  let notifications = Notifications()
  
  override func viewWillAppear(_ animated: Bool) {
    saveChangeSetting()
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    notifications.notificationCenter.delegate = notifications
    notifications.userRequest()
    setTitleChangeLanguage()
    
    }
  
  //MARK: SetTitle
  func setTitleChangeLanguage(){
    apointmentTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.apointmentTitle.rawValue, comment: "")
    
    remainderTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.remainderTitleLb.rawValue, comment: "")
    
    navTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.navTitle.rawValue, comment: "")
    
    notificationLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.notificationTitle.rawValue, comment: "")
  
  }
  
  //MARK:SaveChangeSetting with UserDefault
  func saveChangeSetting(){
    if let apointment = userDefault.value(forKey:SettingKeys.apointmentSwitch.rawValue) as? Bool {
      
      apointmentSwitch.isOn = apointment
      beforeSlider.isEnabled = apointment
      beforeLabel.isEnabled = apointment
      apointmentTitleLabel.isEnabled = apointment
      minuteBeforeLabel.isEnabled = apointment
      
    }
    
    if let remainer = userDefault.value(forKey:SettingKeys.remainderSwitch.rawValue) as? Bool {
      
      remainderSwitch.isOn = remainer
      laterSlider.isEnabled = remainer
      laterLabel.isEnabled = remainer
      remainderTitleLabel.isEnabled = remainer
      dayLatersLabel.isEnabled = remainer
      
    }
    
    if let languages = userDefault.value(forKey:SettingKeys.languagueSwitch.rawValue) as? Bool {
      
      languageSwitch.isOn = languages
      englishBtn.isEnabled = languages
      khmerBtn.isEnabled = languages
      
    }
    
    if let notifications = userDefault.value(forKey:SettingKeys.languagueSwitch.rawValue) as? Bool{
      notificationAlertSwitch.isOn = notifications
      notificationLabel.isEnabled = notifications
    }
    
   if let changeSliderBefore = userDefault.value(forKey: SettingKeys.changeBefore.rawValue) as? Float {
    
    minuteBeforeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.beforeLb.rawValue, comment: "")
    
     beforeLabel.text = String(Int(changeSliderBefore))
      beforeSlider.value = changeSliderBefore
    
    }
    
    if let changeSliderLater = userDefault.value(forKey: SettingKeys.changeLater.rawValue) as? Float {
      
      dayLatersLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.laterLb.rawValue, comment: "")
      laterLabel.text = String(Int(changeSliderLater))
      laterSlider.value = changeSliderLater
    }
    
    if let changeLanguage = userDefault.value(forKey: SettingKeys.changeLanguages.rawValue) as? Int {
      if englishBtn.tag == changeLanguage {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        englishBtn.isSelected = true // open
      }else {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "km")
        khmerBtn.isSelected = true // open
      }
    }
  }
  

  @IBAction func changeLanguageTapped(_ sender: UIButton) {
    if sender.tag == 0 {
      if LocalizationSystem.sharedInstance.getLanguage() == "km" {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        
        khmerBtn.isSelected = false // close
        englishBtn.isSelected = true // open
     
      }
      userDefault.set(sender.tag, forKey: SettingKeys.changeLanguages.rawValue)
    }else {
      if LocalizationSystem.sharedInstance.getLanguage() == "en" {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "km")
        
        englishBtn.isSelected = false
        khmerBtn.isSelected = true
      
      }
      userDefault.set(sender.tag, forKey: SettingKeys.changeLanguages.rawValue)
    }
    
    let storyboard:UIStoryboard = UIStoryboard(storyboard: .Setting)
        let setting = storyboard.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        let appDlg = UIApplication.shared.delegate as? AppDelegate
        let navigationRoot = UINavigationController(rootViewController: setting)
            navigationRoot.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationRoot.navigationBar.shadowImage = UIImage()
            navigationRoot.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
           appDlg?.window?.rootViewController = navigationRoot
    

    
  }
  
  
  
  //MARK:Apointment Switch
  @IBAction func apointmentSwitch(_ sender: UISwitch) {
    
    if sender.isOn {
      self.switchState = true
     userDefault.set(switchState, forKey: SettingKeys.apointmentSwitch.rawValue)
     userDefault.synchronize()
     
      beforeSlider.isEnabled = true
      beforeLabel.isEnabled = true
      apointmentTitleLabel.isEnabled = true
      minuteBeforeLabel.isEnabled = true
      
    }else {
      
      switchState = false
      userDefault.set(switchState, forKey: SettingKeys.apointmentSwitch.rawValue)
      userDefault.synchronize()
      
  
      beforeSlider.isEnabled = false
      beforeLabel.isEnabled = false
      apointmentTitleLabel.isEnabled = false
      minuteBeforeLabel.isEnabled = false
    }
    
  }
  
  @IBAction func RemainderSwitch(_ sender: UISwitch) {
    if sender.isOn {
      self.switchState = true
      userDefault.set(switchState, forKey: SettingKeys.remainderSwitch.rawValue)
      userDefault.synchronize()
      
      laterSlider.isEnabled = true
      laterLabel.isEnabled = true
      remainderTitleLabel.isEnabled = true
      dayLatersLabel.isEnabled = true
      
    }else {
      
      switchState = false
      userDefault.set(switchState, forKey: SettingKeys.remainderSwitch.rawValue)
      userDefault.synchronize()
      
      laterSlider.isEnabled = false
      laterLabel.isEnabled = false
      remainderTitleLabel.isEnabled = false
      dayLatersLabel.isEnabled = false
      
    }
  
  }
  
  @IBAction func languageSwitch(_ sender: UISwitch) {
    if sender.isOn {
      self.switchState = true
      userDefault.set(switchState, forKey: SettingKeys.languagueSwitch.rawValue)
      userDefault.synchronize()
      
      englishBtn.isEnabled = true
      khmerBtn.isEnabled = true
      
    }else {
      switchState = false
      userDefault.set(switchState, forKey: SettingKeys.languagueSwitch.rawValue)
      userDefault.synchronize()
      
      englishBtn.isEnabled = false
      khmerBtn.isEnabled = false
      
    }
   

  }
  
  @IBAction func notificationAlertSwitch(_ sender: UISwitch) {
    
    if sender.isOn {
      
      self.switchState = true
      userDefault.set(switchState, forKey: SettingKeys.notifications.rawValue)
      userDefault.synchronize()
      
      notificationLabel.isEnabled = true
      
    }else {
      
      self.switchState = true
      userDefault.set(switchState, forKey: SettingKeys.notifications.rawValue)
      userDefault.synchronize()
      
      notificationLabel.isEnabled = false
    }
    
  }
  
  //MARK: BackTapped
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    print("back")
  }
  
 
  
  //MARK:  changebefore Slider
  @IBAction func changebeforeSlider(_ sender: UISlider) {
    
    minuteBeforeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.beforeLb.rawValue, comment: "")
    
    let dateTimeBooking = userDefault.value(forKey: ApointmentBooking.dateTimeBooking.rawValue) as? [String]
    let responseDateTime = userDefault.value(forKey: ApointmentBooking.responseDateTime.rawValue) as? [Bool]
    
    let datetimeFormatter = DateFormatter()
      datetimeFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
      datetimeFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let dateTimeShort = DateFormatter()
    dateTimeShort.dateFormat = "dd-MMM-yyyy"
    dateTimeShort.locale = Locale(identifier: "en_US_POSIX")
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    timeFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    
    if dateTimeBooking != nil && responseDateTime != nil {
      for responses in responseDateTime!
      {
        for dateTimesBooking in dateTimeBooking!
        {
          
          if let dateTimes = datetimeFormatter.date(from: dateTimesBooking)
               {
               if responses == true {
                    let timestamp:NSNumber = Int(dateTimes.timeIntervalSince1970) as NSNumber
                    let timeDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: timestamp))
                    print("timeDate:\(timeDate)")
                    let dateSubTime = timeDate.addingTimeInterval(TimeInterval(60.0) - TimeInterval(sender.value * 60.0)) //sub minute * 60 second
            
                    let timeSub = timeFormatter.string(from: dateSubTime as Date)
            
                    let divideTimeComponent = timeSub.components(separatedBy: ":")
            
                    let hours = divideTimeComponent[0]
                    let minutes = divideTimeComponent[1]
            
              self.notifications.scheduleAlarmNotification(hour: hours, minute: minutes)
              }// end if response
              else {
                  print("response is\(responses)")
                }
            }// end If dateTimes
        }// for dateTimesBooking
      }// for response Bool
    }
    
    
    //for dateTimesBooking in dateTimeBooking ?? [""] {
     // print("datetimes:\(String(describing: dateTimesBooking))")
//      if let dateTimes = datetimeFormatter.date(from: dateTimesBooking){
//        let timestamp:NSNumber = Int(dateTimes.timeIntervalSince1970) as NSNumber
//        let timeDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: timestamp))
//        print("timeDate:\(timeDate)")
//        let dateSubTime = timeDate.addingTimeInterval(TimeInterval(60.0) - TimeInterval(sender.value * 60.0)) //sub minute * 60 second
//
//        let timeSub = timeFormatter.string(from: dateSubTime as Date)
//
//        print("timeSub:\(timeSub)")
//
//        let divideTimeComponent = timeSub.components(separatedBy: ":")
//
//        let hours = divideTimeComponent[0]
//        let minutes = divideTimeComponent[1]
//
//        self.notifications.scheduleAlarmNotification(hour: hours, minute: minutes)
//
//      }
 //   }
    
 
    
    beforeLabel.text = String(Int(sender.value))

    
    userDefault.set(sender.value, forKey: SettingKeys.changeBefore.rawValue)
    userDefault.synchronize()
  }
  
  @IBAction func changeLaterSlider(_ sender: UISlider) {
    
    dayLatersLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.laterLb.rawValue, comment: "")
    
    laterLabel.text = String(Int(sender.value))
    
    userDefault.set(sender.value, forKey: SettingKeys.changeLater.rawValue)
    userDefault.synchronize()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}


