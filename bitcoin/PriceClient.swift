//
//  PriceClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import CoreGraphics

protocol PriceClient {
    func lastPrice() -> CGFloat?
    func storePrice(_ price: CGFloat)
    func currentPrice(_ result: @escaping (CGFloat) -> ())
    var type: PriceClientSource { get }
}

extension PriceClient {
    
    func storePrice(_ price: CGFloat) {
        UserDefaults.standard.set(price, forKey: self.type.displayName())
    }
    
    func lastPrice() -> CGFloat? {
        guard let price = UserDefaults.standard.value(forKey: self.type.displayName()) as? CGFloat else {
            return nil
        }
        return price
    }
}
