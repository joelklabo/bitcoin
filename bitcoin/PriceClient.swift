//
//  PriceClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

protocol PriceClient {
    func lastPrice() -> Double?
    func storePrice(_ price: Double)
    func currentPrice(_ result: @escaping (CurrentPrice) -> ())
}

