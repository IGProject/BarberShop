//
//  AppointmentDetailTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 12/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire
class ApointmentDetailTableViewController: UITableViewController{
  @IBOutlet weak var teamName: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var reasonTextView: UITextView!
  
  //MARK: Properties
  var teamNameString:String!
  var dateString:String!
  var locationString:String!
  var serviceString:String!
  var statusString:String!
  
  //MARK:UserDefault
  var userDefault = UserDefaults.standard
  
  var bookId:Int!
  var userId:Int!
  var teamId:Int!
  var locationId:Int!
  var serviceId:Int!
  
  //MARK: Object
  var bookingResponse = BookingResponse(reason: "", booking: [], response: false)
  
  override func viewDidLoad() {
        super.viewDidLoad()
     setTextViewDelegate()
    setupTextLabel()
    }
  
  func setTextViewDelegate(){
    reasonTextView.delegate = self
  }
  func setupTextLabel(){
    teamName.text = teamNameString
    dateLabel.text = dateString
    locationLabel.text = locationString
    statusLabel.text = statusString
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
  }

  
  @IBAction func updateTapped(_ sender: UIBarButtonItem) {
    let storybord:UIStoryboard = UIStoryboard(storyboard: .Booking)
    let editBooking = storybord.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    
    editBooking.teamName = teamNameString
    editBooking.dateTimeString = dateString
    editBooking.locationAddress = locationString
    editBooking.serviceTitle = serviceString
    editBooking.getBookingId = bookId
    editBooking.serviceId = serviceId
    editBooking.teamId = teamId
    editBooking.locationId = locationId
    editBooking.userId = self.userDefault.object(forKey: UserKeys.userId.rawValue) as? Int
    
    navigationController?.pushViewController(editBooking, animated: true)
  }
  

  @IBAction func cancelTapped(_ sender: RoundButton) {
    setupCancelAPI()
  }

  private func setupCancelAPI(){
    if reasonTextView.text.isEmpty {
      AlertController.pleaseWriteReson(on: self)
    }else {
      let cancelEndPoint = URL(string: Domains.BaseURL + "/bookItem/cancel")!
      
      let cancelBooking = CancelBookingResponse(book_id: bookId!, user_reason: reasonTextView.text)
      
      let param:[String:Any] = ["book_id": cancelBooking.book_id,
                                "user_reason": cancelBooking.user_reason]
      
       postCancelBooking(endpoint:cancelEndPoint,param:param)
    }
  
  }
  
  func postCancelBooking(endpoint:URL,param:[String:Any]){
    Alamofire.request(endpoint, method: .post, parameters: param).validate().responseJSON {
      switch $0.result {
      case .success(_):
        do{
          let cancelResponse = try JSONDecoder().decode(BookingResponse.self,
                                                        from: $0.data!)
          
          self.bookingResponse = BookingResponse(reason: cancelResponse.reason,
                                                 booking: cancelResponse.booking,
                                                 response: cancelResponse.response)

              if cancelResponse.response == true {
                 let alertCancel = UIAlertController(title: "Warnning",
                                                     message:cancelResponse.reason,
                                                     preferredStyle: .alert)
                alertCancel.addAction(UIAlertAction(title: "Done",
                                                    style: .default,
                                                    handler: { (actionCancel) in
                        
                  self.navigationController?.popViewController(animated: true)
                                                      
                }))
              self.present(alertCancel, animated: true)
  
              }else {
                print("false")
          }
        }catch let err {
          print("err:\(err.localizedDescription)")
        }
      case .failure(let failure):
        print("failure:\(failure.localizedDescription)")
      }
    }
  }
}

extension ApointmentDetailTableViewController:
UITextViewDelegate {
  
  /* Updated for Swift 4 */
  func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    
    if(text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }

}
