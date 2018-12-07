//
//  AppointmentDetailTableViewController.swift
//  BarberShop-V2
//
//  Created by User on 12/7/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ApointmentDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.selectionStyle = .none
  }
  
  @IBAction func unwindToBooking(segue:UIStoryboardSegue) {}
  
  @IBAction func editBookingTapped(_ sender: RoundButton) {
    let storybord:UIStoryboard = UIStoryboard(storyboard: .Booking)
    let editBooking = storybord.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
    
    navigationController?.present(editBooking, animated: true)
    
  }
  
}
