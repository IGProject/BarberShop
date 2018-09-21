//
//  BookingViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit


@available(iOS 10.0, *)
class BookingViewController: UIViewController{
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var barberTeamTextField: UITextField!
    
    //Picker view
    let my_picker = UIPickerView()
    let dateTime = UIDatePicker()

    let location = ["Battambang","Phnom Penh","Koh Kong","Kompot"]
    let service = ["Exceptional Haircut","Shampoo & Condition","Relaxing hot towel","Eyes Blow & Mustache Trim","Shoulder Message"]
    let barber = ["minea","tony","pheak","raing sey","soriya"]
    
    //hold current array
    var current_arr: [String] = []
    var active_textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        createtoolBar()
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 2/255.0, green: 86/255.0, blue: 153/255.0, alpha: 1)
    }
    
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
          navigationController?.dismiss(animated: true)
    }
    
    func setupPicker(){
        //add Target
        dateTime.addTarget(self, action: #selector(valueDateChange), for: .valueChanged)
        
        //set properties for datetime
        dateTime.datePickerMode = .dateAndTime
        dateTime.minuteInterval = 5
        dateTime.backgroundColor = UIColor(displayP3Red: 63/255, green: 82/255, blue: 106/255, alpha: 1.0)
        dateTime.setValue(UIColor.white, forKey: "textColor")
        
        my_picker.delegate = self
        my_picker.dataSource = self
        my_picker.backgroundColor = UIColor(displayP3Red: 63/255, green: 82/255, blue: 106/255, alpha: 1.0)
        
        
        dateTimeTextField.inputView = dateTime
        locationTextField.inputView = my_picker
        serviceTextField.inputView = my_picker
        barberTeamTextField.inputView = my_picker
    }
    @objc func valueDateChange(sender: UIDatePicker){
        let dateTimeformatter = DateFormatter()
        dateTimeformatter.dateFormat = "dd-MMM-yyyy HH:mm"
        dateTimeTextField.text = "\(dateTimeformatter.string(from: sender.date))"
    }
}

@available(iOS 10.0, *)
extension BookingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        active_textField = textField
        
        switch textField {
        case locationTextField:
            current_arr = location
            break
        case serviceTextField:
            current_arr = service
            break
        case barberTeamTextField:
            current_arr = barber
            break
        default:
            print("Default")
            break
        }
        my_picker.reloadAllComponents()
        return true
    }
    
}

@available(iOS 10.0, *)
extension BookingViewController: UIPickerViewDelegate ,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return current_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = current_arr[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        return myTitle
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return current_arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected item is", current_arr[row])
        active_textField.text = current_arr[row]
    }
    
    func createtoolBar(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let customColor = UIColor(displayP3Red: 63/255, green: 82/255, blue: 106/255, alpha: 1.0)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: customColor], for: .normal)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: customColor], for: .normal)
        
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        dateTimeTextField.inputAccessoryView = toolbar
        locationTextField.inputAccessoryView = toolbar
        serviceTextField.inputAccessoryView = toolbar
        barberTeamTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClick(){
        active_textField.resignFirstResponder()
    }
    @objc func cancelClick(){
        active_textField.text = ""
         active_textField.resignFirstResponder()
    }
}


