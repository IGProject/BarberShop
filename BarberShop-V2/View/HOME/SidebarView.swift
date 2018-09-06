//
//  SidebarView.swift
//  BarberShop
//
//  Created by User on 5/9/18.
//  Copyright © 2018 IG International Group. All rights reserved.
//

import Foundation
import UIKit

protocol SidebarViewDelegate: class {
    func sidebarDidSelectRow(row: Row)
}

enum Row: String {
    case editProfile
    case home
    case my_appointments
    case reward_points
    case notification
    case setting
    case transaction_history
    case about_us
    case signOut
    case none
    
    init(row: Int) {
        switch row {
        case 0: self = .editProfile
        case 1: self = .home
        case 2: self = .my_appointments
        case 3: self = .reward_points
        case 4: self = .notification
        case 5: self = .setting
        case 6: self = .transaction_history
        case 7: self = .about_us
        case 8: self = .signOut
        default: self = .none
        }
    }
}

class SidebarView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var nameAttr = [String]()
    var titleArr = [String]()
    var icon_image = [UIImage]()
    
    weak var delegate: SidebarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.clipsToBounds=true
        
        titleArr = ["Minea Chem","Home", "My Appointments", "Reward Points", "notification", "Setting", "Transaction History","About Us","Sign Out"]
        icon_image = [#imageLiteral(resourceName: "icons8-home-60"),#imageLiteral(resourceName: "icons8-home-60"),#imageLiteral(resourceName: "icons8-calendar-48"),#imageLiteral(resourceName: "icons8-prize-filled-50"),#imageLiteral(resourceName: "icons8-notification-60"),#imageLiteral(resourceName: "icons8-barbershop-48"),#imageLiteral(resourceName: "icons8-time-machine-32"),#imageLiteral(resourceName: "icons8-about-52"),#imageLiteral(resourceName: "icons8-exit-48")]
        
        setupViews()
        
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width - 10, height: cell.frame.height - 10))
            let image = #imageLiteral(resourceName: "blue-dark")
            
            imageView.image = image
            cell.backgroundView = imageView
            //cell.backgroundColor=UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1.0)
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 5, y: 15, width: 80, height: 80))
            cellImg.layer.cornerRadius = 40
            cellImg.layer.masksToBounds=true
            cellImg.contentMode = .scaleAspectFill
            cellImg.layer.masksToBounds=true
            cellImg.image=#imageLiteral(resourceName: "minea")
            cell.addSubview(cellImg)
            
            let cellLbl = UILabel(frame: CGRect(x: 10, y: 110, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font=UIFont.systemFont(ofSize: 20)
            cellLbl.textColor=UIColor.white
            cellLbl.shadowColor = UIColor.black
            
        } else {
            let cellIcon: UIImageView!
            cellIcon = UIImageView(frame: CGRect(x: 10, y:10, width: 30, height: 30))
            
            let cellLblIcon = UILabel(frame: CGRect(x: 60, y: 15, width: 250, height: 30))
            cell.addSubview(cellLblIcon)
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            cellLblIcon.text = titleArr[indexPath.row]
            cellIcon.image = icon_image[indexPath.row]
            cell.addSubview(cellIcon)
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(row: Row(row: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return 60
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
