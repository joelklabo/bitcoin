//
//  BlockchainChartClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation
import CoreGraphics

struct BlockchainChartClient: ChartClient {
    
    let type = ChartClientSource.blockchain
    
    func chartFor(_ range: ChartRange, _ result: @escaping (Chart) -> ()) {
        
        var url: URL? = nil
        
        switch range {
        case .allTime:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=all")
            break
        case .oneYear:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=1year")
            break
        case .oneMonth:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=30days")
            break
        case .sevenDays:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=7days")
            break
        }
        
        guard let safeUrl = url else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: safeUrl) { data, response, error in
            
            guard let data = data else {
                fatalError()
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                fatalError()
            }
            
            guard let values: Array = json["values"] as? Array<[String: Any]> else {
                fatalError()
            }
            
            let prices: [CGFloat] = values.map { value in
                guard let price = value["y"] as? CGFloat else {
                    fatalError()
                }
                return price
            }
            
            DispatchQueue.main.async {
                result(Chart(prices: prices))
            }
        }
        
        task.resume()
    }
    
}
