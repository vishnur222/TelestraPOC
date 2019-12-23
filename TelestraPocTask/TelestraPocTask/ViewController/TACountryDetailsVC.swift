//
//  TACountryDetailsVC.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit

class TACountryDetailsVC: UIViewController {
    
    lazy var countryTableView = UITableView()
    var titleHeader: TAModelTitleHeader!
    var titleRow: [TAModelTitleRow]!
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
        WebServiceManager.shared.getCountryData(completion: {
            (data) in
            self.titleRow = data.rows
            DispatchQueue.main.async {
                self.title = data.title
                self.countryTableView.reloadData()
            }
        })
        setUpNavigation()
        createTableView()
        createRrefreshControl()
    }
    
    func setUpNavigation() {
     //navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.barTintColor = .red
     self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func createTableView(){
            view.addSubview(countryTableView)
        countryTableView.register(UITableViewCell.self, forCellReuseIdentifier: TACountryCustomCellViewTableViewCell.identifierVal)
        countryTableView.register(TACountryCustomCellViewTableViewCell.self, forCellReuseIdentifier: TACountryCustomCellViewTableViewCell.identifierVal)
            countryTableView.dataSource = self
            countryTableView.translatesAutoresizingMaskIntoConstraints = false
            countryTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            countryTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
            countryTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
            countryTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    

}

extension TACountryDetailsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count:Int = titleRow?.count ?? 0
        if(count == 0)
        {
            createErrorLabel()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TACountryCustomCellViewTableViewCell.identifierVal) as? TACountryCustomCellViewTableViewCell else{
                   fatalError(" Please check TableViewCell identifier")
               }
        let currentLastItem = titleRow[indexPath.row]
        cell.product = currentLastItem
        return cell
    }

}

extension TACountryDetailsVC{
    private func createErrorLabel() {
        countryTableView.backgroundView = errorMsgLabel
        errorMsgLabel.text = TAConstants.ConfigMessageValue.initialEmptyMsg
    }
    
    private func createRrefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: TAConstants.ConfigMessageValue.pullToRefreshMsg)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        countryTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        WebServiceManager.shared.getCountryData(completion: {
                  (data) in
                  self.titleRow = data.rows
                  DispatchQueue.main.async {
                    self.title = data.title
                    self.countryTableView.reloadData()
                    self.refreshControl.endRefreshing()

                  }
              })
    }
}
