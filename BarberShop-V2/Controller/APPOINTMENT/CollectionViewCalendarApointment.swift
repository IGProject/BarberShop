//
//  CollectionViewCalendarApointment.swift
//  BarberShop-V2
//
//  Created by User on 12/14/18.
//  Copyright © 2018 minea. All rights reserved.
//
import UIKit
import JTAppleCalendar

extension ApointmentCalendarViewController {
  
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
}

extension ApointmentCalendarViewController {
  
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
}

extension ApointmentCalendarViewController: JTAppleCalendarViewDataSource {
  
 
  
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
