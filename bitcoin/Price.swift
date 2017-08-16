//
//  Price.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct Price: Decodable {
    
    let value: Double
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case value = "y"
        case date = "x"
    }
}
