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
    
    tableViewData.reloadData()
    self.apointment.removeAll()
    self.bookingItems.removeAll()
    setupCalendarView()
    setupApointment()
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       tableViewData.reloadData()
      //setupClearNavigation()
       // setupNavigation()
        setupdayOfWeek()
      
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
   
//  func setupClearNavigation() {
//    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//    self.navigationController?.navigationBar.shadowImage = UIImage()
//    self.navigationController?.navigationBar.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
//    UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0)
//  }
  
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



