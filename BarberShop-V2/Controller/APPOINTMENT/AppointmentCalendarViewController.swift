//
//  AppointmentViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import FSCalendar

class AppointmentCalendarViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
