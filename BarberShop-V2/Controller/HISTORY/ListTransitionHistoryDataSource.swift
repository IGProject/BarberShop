//
//  ListTransitionHistoryDataSource.swift
//  BarberShop-V2
//
//  Created by User on 11/27/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class ListTransitionHistoryDataSource:NSObject,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
    return historyCell
  }
}
