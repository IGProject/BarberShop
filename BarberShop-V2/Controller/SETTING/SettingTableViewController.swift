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
  @IBOutlet weak var languagesLabel: UILabel!
  
  @IBOutlet weak var beforeSlider: UISlider!
  @IBOutlet weak var laterSlider: UISlider!
  
  @IBOutlet weak var apointmentSwitch: UISwitch!
  @IBOutlet weak var remainderSwitch: UISwitch!
  @IBOutlet weak var languageSwitch: UISwitch!
  
  var switchState = false
  
  @IBOutlet weak var englishBtn: UIButton!
  @IBOutlet weak var khmerBtn: UIButton!
  
  
  
  var userDefault = UserDefaults.standard
  let notifications = Notifications()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    notifications.notificationCenter.delegate = notifications
    notifications.userRequest()
    
    setTitleChangeLanguage()
    
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    saveChangeSetting()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tableView.reloadData()
  }
  
  //MARK: SetTitle
  func setTitleChangeLanguage(){
    apointmentTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.apointmentTitle.rawValue, comment: "")
    
    remainderTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.remainderTitleLb.rawValue, comment: "")
    
    navTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.navTitle.rawValue, comment: "")
    
   languagesLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.languageTitleLb.rawValue, comment: "")
    
    minuteBeforeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.beforeLb.rawValue, comment: "")
    
     dayLatersLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.laterLb.rawValue, comment: "")
    
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
    
    
   if let changeSliderBefore = userDefault.value(forKey: SettingKeys.changeBefore.rawValue) as? Float {
    
     beforeLabel.text = String(Int(changeSliderBefore))
      beforeSlider.value = changeSliderBefore
    
    
    
    }
    
    if let changeSliderLater = userDefault.value(forKey: SettingKeys.changeLater.rawValue) as? Float {
      
     
      laterLabel.text = String(Int(changeSliderLater))
      laterSlider.value = changeSliderLater
    }
    
    if let changeLanguage = userDefault.value(forKey: SettingKeys.changeLanguages.rawValue) as? Int {
      if englishBtn.tag == changeLanguage {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        englishBtn.isSelected = true // open
       
        self.tabBarController?.tabBar.items?[0].title = "ជាងកាត់សក់"
        self.tabBarController?.tabBar.items?[1].title = "សេវាកម្ម"
        self.tabBarController?.tabBar.items?[2].title = "ទីតាំងជាង"
        self.tabBarController?.tabBar.items?[3].title = "កក់ជាង"
        self.tabBarController?.tabBar.items?[4].title = "បន្ថែម"
      }else {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "km")
        khmerBtn.isSelected = true // open
        
        self.tabBarController?.tabBar.items?[0].title = "TEAMS"
        self.tabBarController?.tabBar.items?[1].title = "SERVICES"
        self.tabBarController?.tabBar.items?[2].title = "LOCATIONS"
        self.tabBarController?.tabBar.items?[3].title = "BOOKING"
        self.tabBarController?.tabBar.items?[4].title = "MORE"
      }
    }
  }
  

  @IBAction func changeLanguageTapped(_ sender: UIButton) {
    if sender.tag == 0 {
      if LocalizationSystem.sharedInstance.getLanguage() == "km" {
         self.notificationSetLangauge(langCode:"en", isEng: true, isKm: false,sender: sender)
      }
    }else {
      if LocalizationSystem.sharedInstance.getLanguage() == "en" {
        
         self.notificationSetLangauge(langCode: "km", isEng: false, isKm: true,sender:sender)
      }
      
    }
    
  }
  
  func notificationSetLangauge(langCode:String,isEng:Bool,isKm:Bool,sender:UIButton){
    LocalizationSystem.sharedInstance.setLanguage(languageCode:langCode)
    englishBtn.isSelected = isEng
    khmerBtn.isSelected = isKm
    self.setTitleChangeLanguage()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Domains.notificationLanguage), object: nil)
    userDefault.set(sender.tag, forKey: SettingKeys.changeLanguages.rawValue)
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
  
  //MARK: BackTapped
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    
    self.navigationController?.popToRootViewController(animated: true)
  }
  
 
  
  //MARK:  changebefore Slider
  @IBAction func changebeforeSlider(_ sender: UISlider) {
    
    minuteBeforeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.beforeLb.rawValue, comment: "")
    
    let dateTimeBooking = userDefault.value(forKey: ApointmentBooking.dateTimeBooking.rawValue) as? String
    let responseDateTime = userDefault.value(forKey: ApointmentBooking.responseDateTime.rawValue) as? Bool
    
    let datetimeFormatter = DateFormatter()
      datetimeFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
      datetimeFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    timeFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    
    if dateTimeBooking != nil && responseDateTime != nil {
      print("dateTime\(String(describing: dateTimeBooking))")
      if responseDateTime == true {
        let dateTimes = datetimeFormatter.date(from: dateTimeBooking!)
        let timestamp:NSNumber = Int((dateTimes?.timeIntervalSince1970)!) as NSNumber
        let timeDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: timestamp))
        let dateSubTime = timeDate.addingTimeInterval(TimeInterval(60.0) - TimeInterval(sender.value * 60.0))
        let timeSub = timeFormatter.string(from: dateSubTime as Date)
        let divideTimeComponent = timeSub.components(separatedBy: ":")
        
                let hours = divideTimeComponent[0]
                let minutes = divideTimeComponent[1]
        print("hour:\(hours)")
              self.notifications.scheduleAlarmNotificationTime(hour: hours, minute: minutes)
        
            }else {
        
           print("response is\(String(describing: responseDateTime))")
      }
    }
    
    beforeLabel.text = String(Int(sender.value))
    userDefault.set(sender.value, forKey: SettingKeys.changeBefore.rawValue)
    userDefault.synchronize()
  }
  
  @IBAction func changeLaterSlider(_ sender: UISlider) {
    
    dayLatersLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.laterLb.rawValue, comment: "")
    
    let dateTimeBooking = userDefault.value(forKey: ApointmentBooking.dateTimeBooking.rawValue) as? String
    let responseDateTime = userDefault.value(forKey: ApointmentBooking.responseDateTime.rawValue) as? Bool
    
    let datetimeFormatter = DateFormatter()
    datetimeFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    datetimeFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if dateTimeBooking != nil && responseDateTime != nil {
      print("dateTime:\(String(describing: dateTimeBooking))")
      if responseDateTime == true {
        if let startDate = datetimeFormatter.date(from: dateTimeBooking!){
           let endDate = Date(timeInterval: 2*86400, since: startDate)
          
          let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
           let numberOfDays = components.day ?? 0
          
          for _ in 1...numberOfDays {
            let nextDate = Calendar.current.date(byAdding: .day, value:Int(sender.value), to: startDate)
            self.notifications.scheduleAlarmNotificationDate(day: (nextDate?.day())!)
          }
        }
      }
    }
    
    laterLabel.text = String(Int(sender.value))
    
    userDefault.set(sender.value, forKey: SettingKeys.changeLater.rawValue)
    userDefault.synchronize()
    
  }
  
}
