//
//  SettingTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 9/19/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
  @IBOutlet weak var beforeSlider: UISlider!{
    didSet{
      beforeLabel.text = String(Int(beforeSlider.minimumValue.advanced(by: 29))) + " minutes before"
    }
  }
  @IBOutlet weak var beforeLabel: UILabel!
  
  @IBOutlet weak var laterSlider: UISlider!{
    didSet{
      laterLabel.text = String(Int(laterSlider.minimumValue.advanced(by: 14))) + " days laters"
    }
  }
  @IBOutlet weak var laterLabel: UILabel!
  @IBOutlet weak var changeLanguages: UITextField!
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  @IBAction func apointmentSwitch(_ sender: UISwitch) {
    if sender.isOn == true {
       beforeSlider.isEnabled = true
      beforeLabel.isEnabled = true
      
      
    }else {
      beforeSlider.isEnabled = false
      beforeLabel.isEnabled = false
    }
    
  }
  
  
  
  @IBAction func changebeforeSlider(_ sender: UISlider) {
       beforeLabel.text = String(Int(sender.value)) + " minutes before"
  }
  
  
  @IBAction func RemainderSwitch(_ sender: UISwitch) {
    if sender.isOn == true {
       laterSlider.isEnabled = true
      laterLabel.isEnabled = true
    }else {
       laterSlider.isEnabled = false
      laterLabel.isEnabled = false
    }
    
  }
  
  
  @IBAction func changeLaterSlider(_ sender: UISlider) {
    laterLabel.text = String(Int(sender.value)) + " days laters"
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
  }
}
