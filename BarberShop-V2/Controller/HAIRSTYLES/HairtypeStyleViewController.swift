//
//  HairtypeStyleViewController.swift
//  BarberShop-V2
//
//  Created by User on 5/31/18.
//  Copyright © 2018 minea. All rights reserved.
//

import UIKit
import Alamofire

class HairTypeStyleViewController: UIViewController {
    
    @IBOutlet weak var styleTypeCollectionView: UICollectionView!
   private let refreshControl = UIRefreshControl()
  
  var imageStyleTypeString = [String]()
  var listHairTypeDataSource = ListHairTypeDataSource()
  
  override func viewDidDisappear(_ animated: Bool) {
    imageStyleTypeString.removeAll()
    styleTypeCollectionView.reloadData()
  }
  override func viewDidAppear(_ animated: Bool) {
    setLoadingScreen()
    loadData()
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

  
  @IBAction func backTapped(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }
  
  private func setupCollectionView(){
    styleTypeCollectionView.delegate = self
   styleTypeCollectionView.dataSource = listHairTypeDataSource
    
    let strokeTextAttributes = [
      NSAttributedStringKey.foregroundColor : COlorCustom.hexStringToUIColor(hex:"#00695C"),
      NSAttributedStringKey.strokeWidth : -2.0,
      NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
      ] as [NSAttributedStringKey : Any]
    
    refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hair Type Style Data ...", attributes: strokeTextAttributes)
    
    //Add Refresh Control to Table View
    if #available(iOS 10.0, *){
      styleTypeCollectionView.refreshControl = refreshControl
    }else {
      styleTypeCollectionView.addSubview(refreshControl)
    }
    
    //Configure Refresh Controll
    refreshControl.addTarget(self, action: #selector(refreshHairTypeData), for: .valueChanged)
  }
  
  @objc private func refreshHairTypeData(_ sender:Any){
    //Fetch Team Data
    self.render()
  }
  
  private func render(){
    let imageType = imageStyleTypeString.map { return $0}
    listHairTypeDataSource.hairTypeString = imageType
    styleTypeCollectionView.reloadData()
    refreshControl.endRefreshing()
  }
  

  // Load data in the tableView
  private func loadData() {
    // Simulate a delay of some operations as a HTTP Request
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
      
      self.setupCollectionView()
      self.render()
      self.removeLoadingScreen()
      
    }
    
  }
  
  // Set the activity indicator into the main view
  private func setLoadingScreen() {
    
    // Adds text and spinner to the view
    view.addSubview(loadingView)
    loadingView.addSubview(spinner)
    loadingView.addSubview(loadingLabel)
    
    // Sets the view which contains the loading text and the spinner
    let width: CGFloat = 120
    let height: CGFloat = 50
    
    
    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadingView.widthAnchor.constraint(equalToConstant: width).isActive = true
    loadingView.heightAnchor.constraint(equalToConstant: height).isActive = true
    
    spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    spinner.leftAnchor.constraint(equalTo: loadingView.leftAnchor, constant: 5).isActive = true
    spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
    spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
    spinner.startAnimating()
    
    
    // Sets loading text
    loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
    loadingLabel.leftAnchor.constraint(equalTo: spinner.rightAnchor, constant: 5).isActive = true
    
  }
  
  lazy var loadingView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let loadingLabel: UILabel = {
    let label  = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = COlorCustom.hexStringToUIColor(hex: "#00695C")
    label.text = "Loading..."
    return label
  }()
  
  let spinner: UIActivityIndicatorView = {
    let indecator = UIActivityIndicatorView()
    indecator.translatesAutoresizingMaskIntoConstraints = false
    indecator.activityIndicatorViewStyle = .gray
    indecator.color = COlorCustom.hexStringToUIColor(hex: "#00695C")
    return indecator
  }()
  
  
  // Remove the activity indicator from the main view
  private func removeLoadingScreen() {
    
    // Hides and stops the text and the spinner
    spinner.stopAnimating()
    loadingView.removeFromSuperview()
    
    
  }
}

extension HairTypeStyleViewController: UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor(red: 11/255, green: 34/255, blue: 57/255, alpha: 1.0).cgColor
        cell?.layer.borderWidth = 2
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 0.5
    }
}

extension HairTypeStyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets:CGFloat = 3
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing), height: (width/numberOfColumns) - (xInsets + cellSpacing))
    }
}
