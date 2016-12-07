//
//  CoinbaseClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import CoreGraphics

struct CoinbaseClient: PriceClient {
    
    let type = PriceClientSource.coinbase
    
    func currentPrice(_ result: @escaping (CGFloat) -> ()) {
        
        guard let url = URL(string: "https://api.coinbase.com/v2/exchange-rates?currency=BTC") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError()
            }
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                fatalError()
            }
            guard let body = json["data"] as? [String: Any] else {
                fatalError()
            }
            guard let rates = body["rates"] as? [String: Any] else {
                fatalError()
            }
            guard let USDInfo = rates["USD"] as? String else {
                fatalError()
            }
            
            guard let price = NumberFormatter().number(from: USDInfo) else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                result(CGFloat(price))
            }
        }
        
        task.resume()
    }
}
