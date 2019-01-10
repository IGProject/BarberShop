//
//  TableViewDataApointments.swift
//  BarberShop-V2
//
//  Created by User on 12/14/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

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
    
    let cellApointment = tableView.dequeueReusableCell(withIdentifier: "ApointmentTableViewCell", for: indexPath) as! ApointmentTableViewCell
    
    cellApointment.configure(data: apointment[indexPath.row])
   
    return cellApointment
  }
  
}

extension ApointmentCalendarViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
    
    let apointmentDidSelect = apointment[indexPath.row]
    if apointmentDidSelect.status {
      print(apointmentDidSelect.statusNote)
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
