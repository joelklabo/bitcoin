//
//  CurrentPrice.swift
//  bitcoin
//
//  Created by Joel Klabo on 8/15/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import Foundation

struct CurrentPrice {
    
    let last: Double
    let fifteenAgo: Double
    
    enum CodingKeys: String, CodingKey {
        case USD
    }
    
    enum USDKeys: String, CodingKey {
        case last
        case fifteenAgo = "15m"
    }
}

extension CurrentPrice: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let USD = try values.nestedContainer(keyedBy: USDKeys.self, forKey: .USD)
        
        last = try USD.decode(Double.self, forKey: .last)
        fifteenAgo = try USD.decode(Double.self, forKey: .fifteenAgo)
    }
}
