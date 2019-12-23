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
    var products: [Product]!
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
        createProductArray()
    }
    
    func setUpNavigation() {
     navigationItem.title = "Contacts"
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
    
    func createProductArray() {
     products = [Product]()
        products.append(Product(productName: "Glasses", productImage: "imagename" , productDesc: "Testing1 is best Glasses This is best GlassesThis is best GlassesThis is best GlassesThis is best GlassesThis is best GlassesThis is best Glasses "))
        products.append(Product(productName: "Desert", productImage: "Image name" , productDesc: "Testing2 is so yummy "))
        products.append(Product(productName: "Camera Lens", productImage: "iamgwe name", productDesc: "Testing3 I wish I had this camera lens This is best GlassesThis is best GlassesThis is best GlassesThis is best GlassesThis is best GlassesThis is best Glasses"))
    }


}

extension TACountryDetailsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count:Int = products?.count ?? 0
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
        let currentLastItem = products[indexPath.row]
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
        refreshControl.endRefreshing()
    }
}
