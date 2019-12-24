//
//  TAWebserviceManager.swift.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit

protocol TAWebServiceManagerDelegate: class {
    func onSucess(_ tag: NSInteger, with data: TAModelTitleHeader)
    func onFailure(_ tag: NSInteger, with data: String)
}

 class TAWebServiceManager {
    weak var delegate: TAWebServiceManagerDelegate?
    init(delegate: TAWebServiceManagerDelegate) {
            self.delegate = delegate
        }
     
    // MARK: getCountryData web service call
    func getCountryData() {
        let apiTagVal = ApiTag.getCountryDetails.rawValue
        guard let apiUrl = URL(string: "https://api.myjson.com/bins/196ifk") else { return }
     
     if !TAReachability.isConnectedToNetwork() {
        self.delegate?.onFailure(apiTagVal, with: TAConstants.ConfigMessageValue.noInternetMsg)
                     return
             }
       
     URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
              guard let data = data else { return }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == (200)
               else {
                self.delegate?.onFailure(apiTagVal, with: TAConstants.ConfigMessageValue.serverIssueMsg)
                   return  }
        
              do {
                 let decoder = JSONDecoder()
                 let decodedData = try decoder.decode(TAModelTitleHeader.self, from: data)
                self.delegate?.onSucess(apiTagVal, with: decodedData)
              } catch let err {
                print("Error", err)
                  self.delegate?.onFailure(apiTagVal, with: TAConstants.ConfigMessageValue.decodingIssueMsg)
           }
     }.resume()
   }
 }
