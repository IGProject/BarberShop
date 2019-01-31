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
  @IBOutlet weak var updatebtn: UIBarButtonItem!
  
  @IBOutlet weak var bookingBtn: RoundButton!
  @IBOutlet weak var imageProfile: RoundedImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  
  let userDefault = UserDefaults.standard
  
  //Picker view Property
  let my_picker = UIPickerView()
  let dateTime = UIDatePicker()
  let dateTimeformatter = DateFormatter()
  var editBooking:EditBooking!
  
  //
  var teamName:String!
  var serviceTitle:String!
  var locationAddress:String!
  var dateTimeString:String!
  //id
  var getBookingId:Int!
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
  let date = Date()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupPicker()
    createtoolBar()
    //setupClearNavigation()
    setupProfileImage()
    setupServicetitle()
    setupTeamName()
    checkButton()
    setTextField()
    
  
    setDefaultDate()
  }
  
  func setDefaultDate(){
    let defaultDateFormatter = DateFormatter()
    defaultDateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    defaultDateFormatter.locale = Locale(identifier: "en_US_POSIX")
    if dateTimeString == nil {
      dateTimeString = defaultDateFormatter.string(from: Date())
      dateTimeTextField.text = dateTimeString
    }
  }
  
  func setTextField(){
    dateTimeTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.dateTimeTF.rawValue, comment: "")
    
    locationTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.locationTF.rawValue, comment: "")
    
    serviceTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.serviceTF.rawValue, comment: "")
    
    barberTeamTextField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.teamTF.rawValue, comment: "")
    
    bookingBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: BookingBarber.confirmBtnBooking.rawValue, comment: ""), for: .normal)
    
  }
  
  func checkButton(){
    if getBookingId == nil {
      updatebtn.title = ""
      updatebtn.isEnabled = false
      bookingBtn.isHidden = false
    }else {
      updatebtn.title = "Update"
      updatebtn.isEnabled = true
      bookingBtn.isHidden = true
    }
  }
  
  @IBAction func updateBookingTapped(_ sender: UIBarButtonItem) {
    updateBooking()
  }
  
  func updateBooking(){
    let updateBookingEndPoint = URL(string: Domains.BaseURL + "/bookItem/update")!
    
    editBooking = EditBooking(booking_id: getBookingId!, user_id: userId!, work_time: dateTimeString!, location_id: locationId!, seva_id: serviceId!, team_id: teamId!, status: false)
    
    let param:[String:Any] = ["booking_id":editBooking.booking_id,
                              "user_id":editBooking.user_id,
                              "work_time":editBooking.work_time,
                              "location_id":editBooking.location_id,
                              "seva_id":editBooking.seva_id,
                              "team_id":editBooking.team_id,
                              "status":editBooking.status]
    
    updateBookingURL(endpoint:updateBookingEndPoint,param:param)
  }
  
  private func updateBookingURL(endpoint:URL,param:[String:Any]){
    Alamofire.request(endpoint, method: .post, parameters: param, encoding: JSONEncoding.default).validate().responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do {
          let jsonDecoder = JSONDecoder()
          let updateBookingResponse = try jsonDecoder.decode(BookingResponse.self, from: jsonData!)
          self.responseBooking = BookingResponse(reason: updateBookingResponse.reason, booking: updateBookingResponse.booking, response: updateBookingResponse.response)
          
          if updateBookingResponse.response {
            let messageAlert = UIAlertController(title: "Message Alert", message: updateBookingResponse.reason, preferredStyle: .alert)
            messageAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
              self.navigationController?.popViewController(animated: true)
            }))
            self.present(messageAlert, animated: true)
          }else {
            let messageNot = UIAlertController(title: "Message Alert", message: updateBookingResponse.reason, preferredStyle: .alert)
            messageNot.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(_) in
              self.navigationController?.popViewController(animated: true)
            }))
            self.present(messageNot, animated: true)
          }
          
        }catch let error {
          print("error:\(error.localizedDescription)")
        }
        break
      case .failure(let err):
        print("err:\(err.localizedDescription)")
        break
      }
    }
    
  }
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  
  private func setupProfileImage(){
    let urlImage = userDefault.object(forKey: UserKeys.userProfile.rawValue) as! String
    let username = userDefault.object(forKey: UserKeys.usernameText.rawValue) as! String
    let type = userDefault.object(forKey: UserKeys.type.rawValue) as? Int
   // guard let type = userDefault.object(forKey: UserKeys.type.rawValue) as? Int else { return }
    

    
    let url = URL(string: Domains.BaseURL)!
    let urlImg = URL(string: urlImage)!
    
    if type != nil {
      switch type {
      case 3,4:
        imageProfile.kf.setImage(with: urlImg)
      default:
        let urlProfile = url.appendingPathComponent(urlImage)
        imageProfile.kf.setImage(with: urlProfile)
      }
    }
   
    
    
    nameLabel.text = username
    
  }
  
  
  //MARK: Setup ServiceTitle
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
  
  //MARK: Setup Team
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
  
//  func setupClearNavigation() {
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    self.navigationController?.navigationBar.shadowImage  = UIImage()
//    self.navigationController?.navigationBar.backgroundColor = .white
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
  //}
  
  
  @IBAction func confirmBookingTapped(_ sender: RoundButton) {
       confirmBooking()
  }
  
  private func confirmBooking(){
    userId = userDefault.object(forKey: UserKeys.userId.rawValue) as? Int
    
    guard userId != nil else {return}
    guard dateTimeString != nil else { return}
    guard locationId != nil else {return}
    guard serviceId != nil else {return}
    guard teamId != nil else {return}
    
  
    let booking = BookingDetail(user_id: userId, work_time: dateTimeString!, location_id: locationId, service_id: serviceId!, team_id: teamId!)
    
    let bookingEndPoint = URL(string: Domains.BaseURL + "/bookItem/book")!
    let param:[String:Any] = ["team_id":booking.team_id,
                              "work_time":booking.work_time,
                              "user_id":booking.user_id,
                              "service_id":booking.service_id,
                              "location_id":booking.location_id
                              ]
    postBookingBarberShop(bookingEndPoint: bookingEndPoint,param:param)
  }
  
  private func postBookingBarberShop(bookingEndPoint:URL,param:[String:Any]){
  
    Alamofire.request(bookingEndPoint, method: .post, parameters: param).responseJSON {
      switch $0.result {
      case .success(_):
        let jsonData = $0.data
        do{
          let bookingResponse = try JSONDecoder().decode(BookingResponse.self, from: jsonData!)
          self.responseBooking = BookingResponse(reason: bookingResponse.reason,
                                                 booking: bookingResponse.booking,
                                                 response: bookingResponse.response)
          
          if self.responseBooking.response {
            let alertMessage = UIAlertController(title: "Booking",
                                                 message: bookingResponse.reason,
                                                 preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Sucess",
                                       style: .default,
                                       handler: { (action) in
                                        
              let storyboard:UIStoryboard = UIStoryboard(storyboard: .Apointment)
              let apointmentVC = storyboard.instantiateViewController(withIdentifier: "ApointmentCalendarViewController") as! ApointmentCalendarViewController
              apointmentVC.userId = self.userId
              self.navigationController?.popViewController(animated: true)
            })
            
            alertMessage.addAction(action)
            self.present(alertMessage, animated: true)
          }else {
            let alertMessage = UIAlertController(title: "Message", message: self.responseBooking.reason, preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Message", style: .default, handler: nil))
            
            self.present(alertMessage, animated: true)
          }
          
          
        }catch let err {
          print("error:", err.localizedDescription)
        }
      case .failure(let error):
        print("error:\(error.localizedDescription)")
      }
    }
    
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
    dateTimeformatter.dateFormat = "dd-MMM-yyyy HH:mm"
    dateTimeformatter.locale = Locale(identifier: "en_US_POSIX")
    dateTimeString = dateTimeformatter.string(from: sender.date)
    dateTimeTextField.text = dateTimeString
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
 
    if active_textField == locationTextField {
      let locationAddress = teamsBooking.results[row].location.address
      let addressString = NSAttributedString(string: locationAddress, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
      return addressString
      
    }else if active_textField == barberTeamTextField {
      let teamName = teamsBooking.results[row].username
      let teamNameString = NSAttributedString(string: teamName, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
      return teamNameString
      
    }else if active_textField == serviceTextField {
      let serviceTitle = servicesBooking.results[row].title
      let serviceTitleString = NSAttributedString(string: serviceTitle, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
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
    
    
    dateTimeTextField.text = dateTimeString
    locationTextField.text = locationAddress
    serviceTextField.text = serviceTitle
    barberTeamTextField.text = teamName
  }
  
  @objc func doneClick(){
  active_textField.resignFirstResponder()
  }
  @objc func cancelClick(){
    active_textField.text = ""
    active_textField.resignFirstResponder()
  }
}


