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
    func currentPrice(_ result: @escaping (Price) -> ())
    var type: PriceClientSource { get }
}

extension PriceClient {
    
    func storePrice(_ price: Double) {
        UserDefaults.standard.set(price, forKey: self.type.displayName())
    }
    
    func lastPrice() -> Double? {
        guard let price = UserDefaults.standard.value(forKey: self.type.displayName()) as? Double else {
            return nil
        }
        return price
    }
}
