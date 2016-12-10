//
//  ChartClient.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/2/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import Foundation

protocol ChartClient {
    func chartFor(_ range: ChartRange, _ result: @escaping (Chart) -> ())
}

enum ChartRange: Int {
    case allTime
    case oneYear
    case twoYears
    case oneMonth
}
