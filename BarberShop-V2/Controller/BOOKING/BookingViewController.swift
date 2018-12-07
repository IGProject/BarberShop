//
//  BookingViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

@available(iOS 10.0, *)
class BookingViewController: UIViewController{
  
  //MARK: Outlet Connection
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var serviceTextField: UITextField!
    @IBOutlet weak var barberTeamTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imageProfile: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
  
  
  let userDefault = UserDefaults.standard
  
    //Picker view Property
    let my_picker = UIPickerView()
    let dateTime = UIDatePicker()
  
  //
    var teamName:String!
    var serviceTitle:String!
    var locationAddress:String!
    var dateTimeString:String!
   //id
  
  var userId:Int!
  var teamId:Int!
  var serviceId:Int!
  var locationId:Int!
  
  //Create Object Booking
  var teamsBooking = Teams(length:0,results:[])
  var servicesBooking = Services(length:0,results:[])
  var responseBooking = BookingResponse(reason: "", booking: [], response: false)
  
  
    //hold current array
    var current_arr: [String] = []
    var active_textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupPicker()
        createtoolBar()
        setupClearNavigation()
        setupProfileImage()
        setupServicetitle()
        setupTeamName()
      
      userId = userDefault.object(forKey: UserKeys.userId.rawValue) as? Int
    }
  
  private func setupProfileImage(){
//    let urlImage = userDefault.object(forKey: UserKeys.userProfile.rawValue) as! [String]
//    let username = userDefault.object(forKey: UserKeys.usernameText.rawValue) as! String
//    
//     urlImage.map {
//      let url = URL(string: Domains.BaseURL)!
//      let urlProfile = url.appendingPathComponent($0)
//      imageProfile.kf.setImage(with: urlProfile)
//    }
//    
//    nameLabel.text = username
  }
  
  private func setupServicetitle(){
    let serviceEndPoint = URL(string: Domains.BaseURL + "/seva/list")!
    Alamofire.request(serviceEndPoint).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do{
          let jsonDecoder = JSONDecoder()
          let serviceResponse = try jsonDecoder.decode(Services.self, from: jsonData!)
          self.servicesBooking =  Services(length:serviceResponse.length ,results:serviceResponse.results)
        }catch let err {
          print("err:\(err)")
        }
      case .failure(let error):
        print(error.localizedDescription)
        
      }
    }
  }
  
  private func setupTeamName(){
     let teamEndPoint = URL(string: Domains.BaseURL + "/team/list")!
    Alamofire.request(teamEndPoint).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do {
          let jsonDecoder = JSONDecoder()
          let teamResponse = try jsonDecoder.decode(Teams.self, from: jsonData!)
          
          self.teamsBooking = Teams(length:teamResponse.length,results:teamResponse.results)
        }catch let err {
          print("err:\(err)")
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
    
  }

  func setupClearNavigation() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
    }
  
  
  @IBAction func confirmBookingTapped(_ sender: RoundButton) {
   
    checkTextField()
//    let booking = BookingDetail(user_id: userId!, work_time: dateTimeString!, location_id: teamId!, service_id: serviceId!, team_id: serviceId!)
//    let bookingEndPoint = URL(string: Domains.BaseURL + "bookItem/book")!
//    let param:[String:Any] = ["team_id":booking.team_id,
//                              "work_time":booking.work_time,
//                              "user_id":booking.user_id,
//                              "service_id":booking.service_id,
//                              "location_id":booking.location_id,
//    ]
//    postBookingBarberShop(bookingEndPoint: bookingEndPoint,param:param)
  }
  
  private func checkTextField(){
    guard dateTimeTextField.text == "" && locationTextField.text == "" && serviceTextField.text == "" && barberTeamTextField.text == "" else {
      let alertController = UIAlertController(title: "Hello", message: "yes I can to see", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "wow", style: .default, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true)
      return
    }
 
  }
  
  private func postBookingBarberShop(bookingEndPoint:URL,param:[String:Any]){
    
    Alamofire.request(bookingEndPoint, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do{
          let jsonDecoder = JSONDecoder()
          let bookingResponse = try jsonDecoder.decode(BookingResponse.self, from: jsonData!)
          self.responseBooking = BookingResponse(reason: bookingResponse.reason, booking: bookingResponse.booking, response: bookingResponse.response)
          
          
        }catch let err {
          print("error:", err.localizedDescription)
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
    
  }
  
    @IBAction func backTapped(_ sender: UIBarButtonItem) {
      
    }
    
    func setupPicker(){
        //add Target
        dateTime.addTarget(self, action: #selector(valueDateChange), for: .valueChanged)
        //set properties for datetime
        dateTime.datePickerMode = .dateAndTime
        dateTime.minuteInterval = 5
        dateTime.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
        dateTime.setValue(UIColor.white, forKey: "textColor")
      
      //MARK: Set Delegate and DataSource
        my_picker.delegate = self
        my_picker.dataSource = self
        my_picker.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
      
      //MARK: Set All in date Picker and Picker
        dateTimeTextField.inputView = dateTime
        locationTextField.inputView = my_picker
        serviceTextField.inputView = my_picker
        barberTeamTextField.inputView = my_picker
    }
  
    @objc func valueDateChange(sender: UIDatePicker){
        let dateTimeformatter = DateFormatter()
        dateTimeformatter.dateFormat = "dd-MMM-yyyy HH:mm"
        dateTimeTextField.text = "\(dateTimeformatter.string(from: sender.date))"
       dateTimeString = dateTimeformatter.string(from: sender.date)
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
          current_arr = teamsBooking.results.map({ $0.location.address})
            break

        case serviceTextField:
          current_arr = servicesBooking.results.map({ $0.title})
            break

        case barberTeamTextField:
          current_arr = teamsBooking.results.map({ $0.username})
            break
        default:
            break
        }
        my_picker.reloadAllComponents()
        return true
    }
  
  
    
}


@available(iOS 10.0, *)
extension BookingViewController: UIPickerViewDelegate,UIPickerViewDataSource{
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      if active_textField == locationTextField {
        return teamsBooking.results.count
      }else if active_textField == barberTeamTextField {
        return teamsBooking.results.count
      }else if active_textField == serviceTextField {
        return servicesBooking.results.count
      }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

      let locationAddress = teamsBooking.results[row].location.address
      let addressString = NSAttributedString(string: locationAddress, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
     
      let teamName = teamsBooking.results[row].username
      let teamNameString = NSAttributedString(string: teamName, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
      
      let serviceTitle = servicesBooking.results[row].title
      let serviceTitleString = NSAttributedString(string: serviceTitle, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
      
      if active_textField == locationTextField {
        return addressString
      }else if active_textField == barberTeamTextField {
        return teamNameString
      }else if active_textField == serviceTextField {
        return serviceTitleString
      }
      
      return nil

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
      if active_textField == locationTextField {
        locationTextField.text = teamsBooking.results[row].location.address
        locationId = teamsBooking.results[row].location.id
      }else if active_textField == barberTeamTextField {
       barberTeamTextField.text = teamsBooking.results[row].username
       teamId = teamsBooking.results[row].id
      
      }else if active_textField == serviceTextField {
        serviceTextField.text = servicesBooking.results[row].title
        serviceId = servicesBooking.results[row].id
      }
//        print("Selected item is", current_arr[row])
//        active_textField.text = current_arr[row]
    }
  
  
    func createtoolBar(){
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let customColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
        doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: customColor], for: .normal)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: customColor], for: .normal)
        
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        dateTimeTextField.inputAccessoryView = toolbar
        locationTextField.inputAccessoryView = toolbar
        serviceTextField.inputAccessoryView = toolbar
        barberTeamTextField.inputAccessoryView = toolbar
      
         locationTextField.text = locationAddress
         print("locationId:\(String(describing: locationId))")
         serviceTextField.text = serviceTitle
         print("serviceId:\(String(describing: serviceId))")
         barberTeamTextField.text = teamName
         print("teamId:\(String(describing: teamId))")
      
      
    }
    
    @objc func doneClick(){
        active_textField.resignFirstResponder()
    }
    @objc func cancelClick(){
        active_textField.text = ""
        active_textField.resignFirstResponder()
    }
}


