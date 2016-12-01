//
//  CoindeskClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct CoindeskClient: PriceClient {
    
    func currentPrice(_ result: @escaping (Price) -> ()) {
        
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError()
            }
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                fatalError()
            }
            guard let prices = json["bpi"] as? [String: Any] else {
                fatalError()
            }
            guard let USDInfo = prices["USD"] as? [String: Any] else {
                fatalError()
            }
            guard let rate = USDInfo["rate"] as? String else {
                fatalError()
            }
            guard let USDPrice = Double(rate) else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                result(Price(value: USDPrice))
            }
        }
        
        task.resume()
    }
}
