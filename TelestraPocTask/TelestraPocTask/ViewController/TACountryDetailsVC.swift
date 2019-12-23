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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        createTableView()
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
        products.append(Product(productName: "Glasses", productImage: "imagename" , productDesc: "This is best Glasses "))
        products.append(Product(productName: "Desert", productImage: "Image name" , productDesc: "This is so yummy"))
        products.append(Product(productName: "Camera Lens", productImage: "iamgwe name", productDesc: "I wish I had this camera lens"))
    }


}

extension TACountryDetailsVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count:Int = products?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TACountryCustomCellViewTableViewCell.identifierVal) as? TACountryCustomCellViewTableViewCell else
               {
                   fatalError(" Please check TableViewCell identifier")
               }
               cell.textLabel?.text = "text"
        return cell
    }

}
