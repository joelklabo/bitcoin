//
//  ChartClientSource.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

enum ChartClientSource {
    
    case blockchain
    
    func source() -> ChartClient {
        switch self {
        case .blockchain:
            return BlockchainChartClient()
        }
    }
    
}
