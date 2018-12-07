//
//  TransitionHistoryViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit

class TransitionHistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
  
   var listTranHistoryDataSource = ListTransitionHistoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       historyTableView.delegate = self
        historyTableView.dataSource = listTranHistoryDataSource
    }
}

extension TransitionHistoryViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
