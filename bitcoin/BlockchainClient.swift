//
//  BlockchainClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import CoreGraphics

struct BlockchainClient: PriceClient {
    
    let name = "blockchain.info"
    
    func currentPrice(_ result: @escaping (CurrentPrice) -> ()) {
        
        guard let url = URL(string: "https://blockchain.info/ticker") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                fatalError()
            }
            
            let currentPrice = try! JSONDecoder().decode(CurrentPrice.self, from: data)
            
            DispatchQueue.main.async {
                result(currentPrice)
            }
        }
        
        task.resume()
    }
    
    func storePrice(_ price: Double) {
        UserDefaults.standard.set(price, forKey: name)
    }
    
    func lastPrice() -> Double? {
        guard let price = UserDefaults.standard.value(forKey: name) as? Double else {
            return nil
        }
        
        return price
    }
}
