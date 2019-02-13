

//
//  NotificationListener.swift
//  BarberShop-V2
//
//  Created by User on 1/31/19.
//  Copyright © 2019 minea. All rights reserved.
//

import Foundation


protocol NotificationListener {
  func onNotificationLoad(value: Int)
}

protocol GetDataNotificationListener {
  func getDataNotification(data:[Result])
}

protocol NotificationFromAlarm {
  func onNotification(value:Int)
}
