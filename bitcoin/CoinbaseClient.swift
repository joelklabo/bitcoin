//
//  CoinbaseClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct CoinbaseClient: PriceClient {
    
    let type = PriceClientSource.coinbase
    
    func currentPrice(_ result: @escaping (Price) -> ()) {
        
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
            guard let USDPrice = Double(USDInfo) else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                result(Price(value: USDPrice, source: .coinbase))
            }
        }
        
        task.resume()
    }
}
