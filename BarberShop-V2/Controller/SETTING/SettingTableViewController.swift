//
//  SettingTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

enum SettingKeys: String{
  case apointmentSwitch
  case remainderSwitch
  case languagueSwitch
  case isOn
  case changeBefore
  case changeLater
  case saveSetting
  case saveLanguage
  case english
  case khmer
}


class SettingTableViewController: UITableViewController {
  
  
  @IBOutlet weak var saveItemTitle: UIBarButtonItem!
  @IBOutlet weak var navTitle: UINavigationItem!
  
  @IBOutlet weak var apointmentTitleLabel: UILabel!
  @IBOutlet weak var remainderTitleLabel: UILabel!
  @IBOutlet weak var beforeLabel: UILabel!
  @IBOutlet weak var minuteBeforeLabel: UILabel!
  @IBOutlet weak var laterLabel: UILabel!
  @IBOutlet weak var dayLatersLabel: UILabel!
  
  
  @IBOutlet weak var beforeSlider: UISlider!
  @IBOutlet weak var laterSlider: UISlider!
  
  @IBOutlet weak var apointmentSwitch: UISwitch!
  @IBOutlet weak var remainderSwitch: UISwitch!
  @IBOutlet weak var languageSwitch: UISwitch!
  
  
  @IBOutlet weak var englishBtn: UIButton!
  @IBOutlet weak var khmerBtn: UIButton!
  
  
  
  var userDefault = UserDefaults.standard
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    
    saveSetting(saveItemTitle)
    setTitle()
    }
  
  func setTitle(){
    apointmentTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.apointmentTitle.rawValue, comment: "")
    
    remainderTitleLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.remainderTitleLb.rawValue, comment: "")
    
    navTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.navTitle.rawValue, comment: "")
    
    saveItemTitle.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.saveItemTitle.rawValue, comment: "")
    
    
  }
  
  func changeSetting(){
    
    if  let changeBefore = userDefault.value(forKey:SettingKeys.changeBefore.rawValue){
      beforeSlider.value = changeBefore as! Float
      changebeforeSlider(beforeSlider)
    }
    
    if let changeLater = userDefault.value(forKey: SettingKeys.changeLater.rawValue){
      laterSlider.value = changeLater as! Float
      changeLaterSlider(laterSlider)
    }
    
    if let apointment = userDefault.value(forKey: SettingKeys.apointmentSwitch.rawValue){
      apointmentSwitch.isOn = apointment as! Bool
        beforeSlider.isEnabled = apointmentSwitch.isOn
        beforeLabel.isEnabled = apointmentSwitch.isOn
    }
    
    if let remainder = userDefault.value(forKey: SettingKeys.remainderSwitch.rawValue){
          remainderSwitch.isOn = remainder as! Bool
          laterSlider.isEnabled = remainderSwitch.isOn
          laterLabel.isEnabled = remainderSwitch.isOn

    }
   
  }
  

  @IBAction func changeLanguageTapped(_ sender: UIButton) {
    if sender.tag == 0 && LocalizationSystem.sharedInstance.getLanguage() == "km"{
      LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
      khmerBtn.isSelected = false
      englishBtn.isSelected = true
      
    }else {
      LocalizationSystem.sharedInstance.setLanguage(languageCode: "km")
      englishBtn.isSelected = false
      khmerBtn.isSelected = true
    }
    
    let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
    let appDlg = UIApplication.shared.delegate as? AppDelegate
    let navigationRoot = UINavigationController(rootViewController: setting)
    navigationRoot.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationRoot.navigationBar.shadowImage = UIImage()
    
    navigationRoot.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    appDlg?.window?.rootViewController = navigationRoot
    
  }
  
  
  
  //MARK:Apointment Switch
  @IBAction func apointmentSwitch(_ sender: UISwitch) {
    userDefault.set(sender.isOn, forKey: SettingKeys.apointmentSwitch.rawValue)
  }
  
  @IBAction func RemainderSwitch(_ sender: UISwitch) {
  userDefault.set(sender.isOn, forKey: SettingKeys.remainderSwitch.rawValue)
  }
  
  @IBAction func languageSwitch(_ sender: UISwitch) {
    userDefault.set(sender.isOn, forKey: SettingKeys.languagueSwitch.rawValue)
  }
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    print("back....")
  }
  
  //MARK:Save Setting
  @IBAction func saveSetting(_ sender: UIBarButtonItem) {
     changeSetting()
  }
  
  //MARK:  changebefore Slider
  @IBAction func changebeforeSlider(_ sender: UISlider) {
    minuteBeforeLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.beforeLb.rawValue, comment: "")
    beforeLabel.text = String(Int(sender.value))
    userDefault.set(sender.value, forKey: SettingKeys.changeBefore.rawValue)
  }
  
  @IBAction func changeLaterSlider(_ sender: UISlider) {
    dayLatersLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: SettingTable.laterLb.rawValue, comment: "")
    laterLabel.text = String(Int(sender.value))
    userDefault.set(sender.value, forKey: SettingKeys.changeLater.rawValue)
  }
}


