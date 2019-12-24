//
//  TAConstants.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import Foundation


enum ApiTag: Int {
    case getCountryDetails = 1000
}

class TAConstants: NSObject {
    
    struct ConfigMessageValue {
        static let initialEmptyMsg = "No Data available to display"
        static let pullToRefreshMsg = "Pull to refresh"
        static let noInternetMsg = "Please check your network conectivity"
        static let decodingIssueMsg = "Decoding failure"
        static let serverIssueMsg = "Not able to connect server try agian later"
    }
    
}

