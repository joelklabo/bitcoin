//
//  PriceClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

protocol PriceClient {
    func currentPrice(_ result: @escaping (Price) -> ())
}

enum PriceClientSource: Int {
    
    case coinbase
    case blockchain
    case coindesk
    
    case total
    
    func source() -> PriceClient {
        switch self {
        case .coinbase:
            return CoinbaseClient()
        case .coindesk:
            return CoindeskClient()
        case .blockchain:
            return BlockchainClient()
        default:
            fatalError("unknown client")
        }
    }
    
    func displayName() -> String {
        switch self {
        case .coinbase:
            return "Coinbase"
        case .coindesk:
            return "Coindesk"
        case .blockchain:
            return "Blockchain.info"
        default:
            fatalError("unknown source")
        }
    }
}
