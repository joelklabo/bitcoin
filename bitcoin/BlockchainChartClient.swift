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
        case .twoYears:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=2years")
            break
        case .oneYear:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=1year")
            break
        case .oneMonth:
            url = URL(string: "https://api.blockchain.info/charts/market-price?format=json&timespan=30days")
            break
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {
                fatalError()
            }
            
//            guard let jsonString = String(data: data, encoding: .utf8) else {
//              fatalError()
//            }
//            
//            print(jsonString)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let chart = try! decoder.decode(Chart.self, from: data)
            
            print(chart.prices.count)
            
            DispatchQueue.main.async {
                result(chart)
            }
        }
        
        task.resume()
    }
    
}
