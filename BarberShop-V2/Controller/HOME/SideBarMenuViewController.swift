//
//  SideBarMenuViewController.swift
//  BarberShop-V2
//
//  Created by User on 9/13/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit


class SideBarMenuViewController: UIViewController {
    @IBOutlet weak var sidebarTableView: UITableView!
    
    var profile = ["image":"minea","username":"minea","email":"minea.chem@gmail.com"]
    
    var iconContent = [UIImage(named: "avatar-user")!,UIImage(named: "home")!,UIImage(named: "calendar-white")!,UIImage(named: "award-point")!,UIImage(named: "notification-30")!,UIImage(named: "settings-white")!,UIImage(named: "order-history")!,UIImage(named: "about"),UIImage(named: "logout")!]
    
    var titleContent = ["profile","home","appointment","award point","notification","setting","history","about us","logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sidebarTableView.delegate = self
        sidebarTableView.dataSource = self
        
        setupClearNavigation()
    }
    
    func setupClearNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
}

extension SideBarMenuViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            profileCell.profileImageView.image =  UIImage(named: profile["image"]!)
            profileCell.usernameLabel.text = profile["username"]
            profileCell.emailLabel.text = profile["email"]
            
            if indexPath.row == 0 {
                tableView.separatorStyle = .singleLineEtched
            }
            return profileCell
        }
        
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell
        contentCell.iconImageView.image = iconContent[indexPath.row]
        contentCell.contentLabel.text = titleContent[indexPath.row]
        
        switch indexPath.row {
        case 3:
            tableView.separatorStyle = .singleLineEtched
        case 6:
            tableView.separatorStyle = .singleLineEtched
        default:
            tableView.separatorStyle = .none
        }
        
        return contentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.backgroundColor = UIColor.blue.cgColor
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.backgroundColor = UIColor.clear.cgColor
    }
}
