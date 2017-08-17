//
//  BlockchainChartClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

struct BlockchainChartClient: ChartClient {
    
    let type = ChartClientSource.blockchain
    
    func chartFor(_ range: ChartRange, _ result: @escaping (Chart) -> ()) {
        
        let baseURL = "https://api.blockchain.info/charts/market-price?format=json&timespan="
        let url = URL(string: baseURL + range.rawValue)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            guard let data = data else {
                fatalError()
            }
            
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
