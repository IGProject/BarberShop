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
  
  func setupCalendarView() {
    
    calendarView.dropShadowBottom()
    calendarView.minimumLineSpacing = 0
    calendarView.minimumInteritemSpacing = 0
    
    calendarView.scrollToDate(Date(),animateScroll: false)
    calendarView.selectDates([Date()])
  }
  
  func setupViewsFromCalendar(from visibleDates: DateSegmentInfo ) {
    guard let date = visibleDates.monthDates.first?.date else { return }
    formatter.dateFormat = "MMMM"
    title = formatter.string(from: date).uppercased()
  }
}

extension ApointmentCalendarViewController: JTAppleCalendarViewDataSource {
  
  func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    
    formatter.dateFormat = "dd MMM yyyy"
    formatter.timeZone = Calendar.current.timeZone
    formatter.locale = Calendar.current.locale
    
    var parameters: ConfigurationParameters
    var startDate = Date()
    var endDate = Date()
    if let calendarStartDate = formatter.date(from: "01 Jan 2018"),
      let calendarEndDate = formatter.date(from: "31 Dec 2018") {
      
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
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    return cell
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
   // let dateUpdate = "22-Dec-2018"
   self.apointment.removeAll()
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
  
     getApointmentByDate(date:date)
  
  }
  
  func getApointmentByDate(date:Date){
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "dd-MMM-yyyy"
    
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
    
    for response in  self.bookingItems {
      let dateString = dateStringFormatter.date(from: response.workTime)
      let dateWorking = dateFormate.string(from: dateString!)
      if dateWorking == dateFormate.string(from: date){
        self.apointment.append(response)
        self.setupTableView()
        DispatchQueue.main.async {
          self.tableViewData.reloadData()
        }
      }
    }
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    
    self.apointment.removeAll()
    
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    
     getApointmentByDate(date: date)
    
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    setupViewsFromCalendar(from: visibleDates)
  }
}
