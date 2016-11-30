//
//  PriceClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

protocol PriceClient {
    static func currentPrice(_ result: @escaping (Price) -> ())
}
