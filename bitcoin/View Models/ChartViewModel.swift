//
//  ChartViewModel.swift
//  bitcoin
//
//  Created by Joel Klabo on 8/15/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import Foundation

typealias RelativePoint = (x: Double, y: Double)

public struct ChartViewModel {
    
    let line: [RelativePoint]
    let maxPriceLocation: RelativePoint
    let maxPriceString: String
    let startDate: String
    let endDate: String
    
    public var maxPoints = 30
    
    init(withChart chart: Chart) {
    
        let numPrices = chart.prices.count
        
        // Find max price
        var maxPrice: (value: Double, index: Int) = (0,0)
        for (index, price) in chart.prices.enumerated() {
            if price.value > maxPrice.value {
                maxPrice = (price.value, index)
            }
        }
        maxPriceString = String(format: "%.02f", maxPrice.value)
        
        // Find max price location
        maxPriceLocation = (x: Double((maxPrice.index + 1) / numPrices), y: 1)
        
        // Find start and end dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        
        guard let firstPrice = chart.prices.first,
              let lastPrice = chart.prices.last else {
                fatalError("No points in chart")
        }
        
        startDate = dateFormatter.string(from: firstPrice.date)
        endDate = dateFormatter.string(from: lastPrice.date)
        
        let relativeYValues = chart.prices.map({ $0.value }).map({ $0 / maxPrice.value })
        
        var relativePoints: [RelativePoint] = []
        for (index, yValue) in relativeYValues.enumerated() {
            relativePoints.append((x: Double( index / numPrices ), y: yValue))
        }
        
        line = relativePoints
    }
}
