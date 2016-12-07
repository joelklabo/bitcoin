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
    
    let type = PriceClientSource.blockchain
    
    func currentPrice(_ result: @escaping (CGFloat) -> ()) {
        
        guard let url = URL(string: "https://blockchain.info/ticker") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                fatalError()
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                fatalError()
            }
            
            guard let USDPrices = json["USD"] as? [String: Any] else {
                fatalError()
            }
            
            guard let lastUSDPrice = USDPrices["last"] as? NSNumber else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                result(CGFloat(lastUSDPrice))
            }
        }
        
        task.resume()
    }
}
