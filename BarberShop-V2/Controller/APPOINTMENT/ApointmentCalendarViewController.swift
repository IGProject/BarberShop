//
//  AppointmentViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Alamofire

enum ApointmentBooking:String{
  case dateTimeBooking
  case responseDateTime
}

class ApointmentCalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableViewData: UITableView!
  
  @IBOutlet weak var sunLabel: UILabel!
  @IBOutlet weak var monLabel: UILabel!
  @IBOutlet weak var tueLabel: UILabel!
  @IBOutlet weak var wedLabel: UILabel!
  @IBOutlet weak var thuLabel: UILabel!
  @IBOutlet weak var friLabel: UILabel!
  @IBOutlet weak var satLabel: UILabel!
  
  
  
    let userDefault = UserDefaults.standard
    let formatter = DateFormatter()
    var dateFutureString:String!
    let todaysDate = Date()
 
  
    var bookingItems = [Booking]()
    var apointment = [Booking]()
   //MARK:Id
  var userId:Int! 
  
  
    // Calendar Color
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.darkGray
    let selectedMonthColor = UIColor.white
    let currentDateSelectedViewColor = UIColor.black
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupCalendarView()
    setupApointment()
    tableViewData.reloadData()
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupdayOfWeek()
      
    }
  
  func setupApointment(){
    let apointment = Apointment(user_id: userId!)
    let apointmentEndPoint = URL(string: Domains.BaseURL + "/bookItem/appointment")!
    let param:[String:Int] = ["user_id":apointment.user_id]
    postApointment(endpoint:apointmentEndPoint,param:param)
  }
  
  func postApointment(endpoint:URL,param:[String:Any]){
    Alamofire.request(endpoint, method: .post, parameters: param).responseJSON { response in
      switch response.result {
      case .success(_):
        let jsonData = response.data
        do{
          let apointmentResponse = try JSONDecoder().decode(ApointmentResponse.self, from: jsonData!)
          
          self.bookingItems  =  apointmentResponse.booking
          
          
        }catch let err {
          print("error:", err.localizedDescription)
        }
      case .failure(let error):
        print("failure:\(error.localizedDescription)")
      }
    }
  }
  
  
  
  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
  }
  func setupdayOfWeek(){
    monLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.mondeyKey.rawValue, comment: "")
    tueLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.tuesdayKey.rawValue, comment: "")
    wedLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.wednesdayKey.rawValue, comment: "")
    thuLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.mondeyKey.rawValue, comment: "")
    friLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.fridayKey.rawValue, comment: "")
    satLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.satursdayKey.rawValue, comment: "")
    sunLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: ApointmentBarber.sundayKey.rawValue, comment: "")
  }
  
  func setupCalendarView() {
    calendarView.dropShadowBottom()
    calendarView.minimumLineSpacing = 0
    calendarView.minimumInteritemSpacing = 0
    calendarView.scrollToDate(Date(),animateScroll: false)
  
    
  }
  
   func setupTableView(){
    tableViewData.delegate = self
    tableViewData.dataSource = self
  }

  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  @IBAction func addBookingTapped(_ sender: RoundButton) {
    let storyboard: UIStoryboard = UIStoryboard(storyboard: .Booking)
    let booking = storyboard.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    
   booking.dateTimeString = dateFutureString
  
  navigationController?.pushViewController(booking, animated: true)
  }
  
}
extension ApointmentCalendarViewController: JTAppleCalendarViewDataSource {
  
  func fullDayPredicate(for date: Date) -> NSPredicate {
    var calendar = Calendar.current
    calendar.timeZone = NSTimeZone.local
    
    let dateFrom = calendar.startOfDay(for: date)
    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dateFrom)
    components.day! += 1
    let dateTo = calendar.date(from: components)
    let datePredicate = NSPredicate(format: "(%@ <= date) AND (date < %@)", argumentArray: [dateFrom, dateTo as Any])
    return datePredicate
  }
  
  
  func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
    guard let validCell = view as? CalendarDayCell else { return }
    if cellState.isSelected {
      validCell.selectedView.isHidden = false
    } else {
      validCell.selectedView.isHidden = true
    }
  }
  
  
  func handleCellVisibility(cell:JTAppleCell,cellState:CellState){
    guard let cell = cell as? CalendarDayCell else { return }
    cell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
  }
  
  func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
    guard let validCell = view as? CalendarDayCell else {
      return
    }
    
    let todaysDate = Date()
    if todaysDate.day() == cellState.date.day() {
      validCell.dateLabel.textColor = UIColor.purple
    } else {
      validCell.dateLabel.textColor = cellState.isSelected ? UIColor.purple : UIColor.darkGray
    }
    
    if cellState.isSelected {
      validCell.dateLabel.textColor = selectedMonthColor
    } else {
      if cellState.dateBelongsTo == .thisMonth {
        validCell.dateLabel.textColor = monthColor
      } else {
        validCell.dateLabel.textColor = outsideMonthColor
      }
    }
  }
  
  
  func setupViewsFromCalendar(from visibleDates: DateSegmentInfo ) {
    guard let date = visibleDates.monthDates.first?.date else { return }
    
    formatter.dateFormat = "MMMM-yyyy"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    title = formatter.string(from: date).uppercased()
    
    //reload tableView
    calendarView.selectDates([Date()])
    DispatchQueue.main.async {
      self.tableViewData.reloadData()
      self.calendarView.reloadDates([date])
    }
    
  }
  
func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
  
  formatter.dateFormat = "dd MMM yyyy"
  formatter.timeZone = Calendar.current.timeZone
  formatter.locale = Calendar.current.locale
  formatter.locale = Locale(identifier: "en_US_POSIX")
  
  var parameters: ConfigurationParameters
  var startDate = Date()
  var endDate = Date()
  
  if let calendarStartDate = formatter.date(from: "01 Jan 2019"),
    let calendarEndDate = formatter.date(from: "31 Dec 2050") {
    
    startDate = calendarStartDate
    endDate = calendarEndDate
  }
  parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
  return parameters
}
}

extension ApointmentCalendarViewController:UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return apointment.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cellApointment = tableView.dequeueReusableCell(withIdentifier: "ApointmentTableViewCell",
                                                       for: indexPath) as! ApointmentTableViewCell
    
    cellApointment.configure(data:apointment[indexPath.row])
    
    self.userDefault.set(self.apointment[indexPath.row].status, forKey: ApointmentBooking.responseDateTime.rawValue)
    
    self.userDefault.set(self.apointment[indexPath.row].workTime, forKey: ApointmentBooking.dateTimeBooking.rawValue)
    
    return cellApointment
  }
  
}

extension ApointmentCalendarViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
    
    let apointmentDidSelect = apointment[indexPath.row]
    if apointmentDidSelect.status { // if status equal true
      let alertController = UIAlertController(title: "Alert Message", message: apointmentDidSelect.statusNote, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
      self.present(alertController, animated: true)
      
    }else {
      
      let storyBoard: UIStoryboard = UIStoryboard(storyboard: .Apointment)
      let apointmentDetail = storyBoard.instantiateViewController(withIdentifier: "ApointmentDetailTableViewController") as! ApointmentDetailTableViewController
      apointmentDetail.teamNameString = apointmentDidSelect.team.team
      apointmentDetail.dateString = apointmentDidSelect.workTime
      apointmentDetail.locationString = apointmentDidSelect.location.location
      apointmentDetail.serviceString = apointmentDidSelect.service.service
      apointmentDetail.statusString = apointmentDidSelect.statusNote
      apointmentDetail.bookId = apointmentDidSelect.id
      apointmentDetail.locationId = apointmentDidSelect.location.id
      apointmentDetail.serviceId = apointmentDidSelect.service.id
      apointmentDetail.teamId = apointmentDidSelect.team.id
      
      self.navigationController?.pushViewController(apointmentDetail, animated: true)
    }
    
  }
}


extension ApointmentCalendarViewController: JTAppleCalendarViewDelegate {
  func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    
  }
  
  
  func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
    
    cell.dateLabel.text = cellState.text
    cell.dotImage.alpha = 0
    
    
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    handleCellVisibility(cell:cell,cellState:cellState)
    setDotCalendar(date: date, cell: cell)
    return cell
  }
  
  //MARK: Function set Dot(.) Calendar
  func setDotCalendar(date:Date,cell:CalendarDayCell){
    
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd-MMM-yyyy"
    dateFormate.locale = Locale(identifier: "en_US_POSIX")
    
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy hh:mm"
    dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    
    DispatchQueue.main.async {
      for datetime in self.bookingItems{
        guard let dateTime = datetime.workTime else {continue}
        let dateComponents = dateTime.components(separatedBy: " ")
        
        let splitDate = dateComponents[0]
        
        if let dates = dateFormate.date(from: splitDate){
          let convertedDate = dateFormate.string(from: dates)
          
          let dateCurrent = dateFormate.string(from: date)
          
          if convertedDate == dateCurrent {
            cell.dotImage.alpha = 1
            self.calendarView.reloadDates([dates])
          }
        }
      }//End For Loop
    } // End DipatchQueue
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
    
    self.apointment.removeAll()
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    
    
    //MARK:Add Date by Calendar to Booking
    addDateByCalendarToBooking(date:date)
    
    //MARK: Get ApointmentByDate
    getApointmentByDate(date:date)
    
  }
  
  func addDateByCalendarToBooking(date:Date){
    formatter.dateFormat = "dd-MMM-yyyy"
    formatter.timeZone = Calendar.current.timeZone
    formatter.locale = Calendar.current.locale
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    let timestamp:NSNumber = Int(NSDate().timeIntervalSince1970) as NSNumber
    let timeDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: timestamp))
    let dateAddTime = timeDate.addingTimeInterval(30.0 * 60.0) //add 30 minute * 60 second
    let timeNormal = timeDate.addingTimeInterval(0.0)
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm"
    
    if date > Date(){
      let timeAfter = timeFormatter.string(from: timeNormal as Date)
      dateFutureString = formatter.string(from: date) + " \(timeAfter)"
    }else {
      let timeCalendar = timeFormatter.string(from: dateAddTime as Date)
      dateFutureString = formatter.string(from: date) + " \(timeCalendar)"
    }
    
  }
  //////////////////////
  
  func getApointmentByDate(date:Date){
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd-MMM-yyyy"
    dateFormate.locale = Locale(identifier: "en_US_POSIX")
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    for response in self.bookingItems {
      
      if let dateString = dateStringFormatter.date(from: response.workTime){
        
        let dateWorking = dateFormate.string(from: dateString)
        if dateWorking == dateFormate.string(from: date){
          self.apointment.append(response)
          self.setupTableView()
          DispatchQueue.main.async {
            self.tableViewData.reloadData()
            
          }
        }
      }
    }
  }
  
  
  /////////////////////////
  
  func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
    self.apointment.removeAll()
    
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    
    getApointmentByDate(date: date)
    
  }
  
  
  
  func calendar(_ calendar: JTAppleCalendarView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    self.apointment.removeAll()
    self.calendarView.reloadData()
  }
  
  
  func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    self.apointment.removeAll()
    self.calendarView.reloadData()
    setupViewsFromCalendar(from: visibleDates)
}

}
