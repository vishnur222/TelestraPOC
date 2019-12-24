//
//  TAViewIdentifier.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import UIKit
protocol IdentifierProtocol { }

extension IdentifierProtocol where Self: UIView {
    static var identifierVal: String {
        return String(describing: self)
    }
}
extension UIView: IdentifierProtocol {}
