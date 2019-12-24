//
//  TAModelTitleHeader.swift
//  TelestraPocTask
//
//  Created by v.r.ramachandran on 23/12/19.
//  Copyright © 2019 v.r.ramachandran. All rights reserved.
//

import Foundation
struct ModelTitleHeader : Codable {
    let title : String?
    let rows : [ModelTitleRow]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([ModelTitleRow].self, forKey: .rows)
    }

}
