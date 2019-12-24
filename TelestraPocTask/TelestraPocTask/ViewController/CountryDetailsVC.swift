//
//  TACountryDetailsVC.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit

class CountryDetailsVC: UIViewController {
  
  lazy var countryTableView = UITableView()
  var titleHeader: ModelTitleHeader!
  var titleRow: [ModelTitleRow]!
  var webServiceManager: WebServiceManager!
  lazy var refreshControl = UIRefreshControl()
  lazy var errorMsgLabel : UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 21)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.sizeToFit()
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigation()
    createTableView()
    createRrefreshControl()
  }
  
  override func viewWillAppear(_ animated: Bool)
  {
    webServiceManager = WebServiceManager(delegate: self)
    WebServiceManager(delegate: self).getCountryData()
    
  }
  // MARK: UINavigation setup
  func setUpNavigation() {
    self.navigationController?.navigationBar.barTintColor = .lightGray
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
  }
  
  // MARK: Tableview creation
  // Table view creation and providing autolayout constriants
  func createTableView(){
    view.addSubview(countryTableView)
    countryTableView.tableFooterView = UIView(frame: .zero)
    countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: CountryCustomCellViewTableViewCell.identifierVal)
    countryTableView.register(CountryCustomCellViewTableViewCell.self, forCellReuseIdentifier: CountryCustomCellViewTableViewCell.identifierVal)
    countryTableView.dataSource = self
    countryTableView.translatesAutoresizingMaskIntoConstraints = false
    countryTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
    countryTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
    countryTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    countryTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
  }
}

extension CountryDetailsVC: UITableViewDataSource{
  // MARK: UITableViewDataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count:Int = titleRow?.count ?? 0
    if(count == 0)
    {
      createErrorLabel()
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCustomCellViewTableViewCell.identifierVal) as? CountryCustomCellViewTableViewCell else{
      fatalError(" Please check TableViewCell identifier")
    }
    let currentLastItem = titleRow[indexPath.row]
    cell.product = currentLastItem
    cell.selectionStyle = .none
    return cell
  }
  
}

extension CountryDetailsVC{
  // MARK: Custom view and fucntionalities implemented in TableView
  private func createErrorLabel() {
    countryTableView.backgroundView = errorMsgLabel
    errorMsgLabel.text = Constants.ConfigMessageValue.initialEmptyMsg
  }
  
  // Pull to refresh fucntionality
  private func createRrefreshControl() {
    refreshControl.attributedTitle = NSAttributedString(string: Constants.ConfigMessageValue.pullToRefreshMsg)
    refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
    countryTableView.addSubview(refreshControl)
  }
  
  @objc func refresh(sender:AnyObject) {
    WebServiceManager(delegate: self).getCountryData()
  }
}

extension CountryDetailsVC: WebServiceManagerDelegate{
  // MARK: response Sucess/failure call back methods
  func onSucess(_ tag: NSInteger, with data: ModelTitleHeader){
    self.titleRow = data.rows
    DispatchQueue.main.async {
      self.title = data.title
      self.countryTableView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  func onFailure(_ tag: NSInteger, with reason: String){
    showAlert(title: Constants.ConfigMessageValue.alertTitle, message: reason)
  }
  func showAlert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: Constants.ConfigMessageValue.alertOkBtn, style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}


