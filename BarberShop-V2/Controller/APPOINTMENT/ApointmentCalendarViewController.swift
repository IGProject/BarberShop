//
//  AppointmentViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ApointmentCalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableViewData: UITableView!
    let userDefault = UserDefaults.standard
    let formatter = DateFormatter()
  var dateFutureString:String!
  
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
        setupNavigation()
    
    }
  
  
  private func setupNavigation(){
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Calendar", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
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



