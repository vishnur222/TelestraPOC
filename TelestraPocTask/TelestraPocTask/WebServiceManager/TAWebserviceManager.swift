//
//  TAWebserviceManager.swift.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit
class WebServiceManager {

    static let shared = WebServiceManager()
    
func getCountryData(completion: @escaping (TAModelTitleHeader) -> Void) {
    
    guard let apiUrl = URL(string: "https://api.myjson.com/bins/iij5n") else { return }
    
    if !TAReachability.isConnectedToNetwork() {
                print("No net")
                    return
            }
    URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
             guard let data = data else { return }
             do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(TAModelTitleHeader.self, from: data)
                completion(decodedData)
             } catch let err {
                 print("Error", err)
          }
    }.resume()
  }
}
