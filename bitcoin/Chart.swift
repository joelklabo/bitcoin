//
//  Chart.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct Chart: Decodable {
    
    let prices: [Price]
    
    enum CodingKeys: String, CodingKey {
        case prices = "values"
    }
}
