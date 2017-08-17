//
//  ChartViewModelTests.swift
//  Tests
//
//  Created by Joel Klabo on 8/16/17.
//  Copyright © 2017 Joel Klabo. All rights reserved.
//

import XCTest

class ChartViewModelTests: XCTestCase {
    
    var chart = Chart(prices: [])
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMaxPriceLocation() {
        let prices = [Price(value: 2, date: Date(timeIntervalSince1970: 0)),
                      Price(value: 3, date: Date(timeIntervalSince1970: 1)),
                      Price(value: 5, date: Date(timeIntervalSince1970: 2)),
                      Price(value: 1, date: Date(timeIntervalSince1970: 3))]
        
        let chart = Chart(prices: prices)
        
        let chartViewModel = ChartViewModel(withChart: chart)
        
        XCTAssert(chartViewModel.maxPriceLocation.y == 1)
        XCTAssert(chartViewModel.maxPriceLocation.x == Double(3/4))
    }
    
    func testMaxPriceString() {
        let prices = [Price(value: 2, date: Date(timeIntervalSince1970: 0)),
                      Price(value: 3, date: Date(timeIntervalSince1970: 1)),
                      Price(value: 5, date: Date(timeIntervalSince1970: 2)),
                      Price(value: 1, date: Date(timeIntervalSince1970: 3))]
        
        let chart = Chart(prices: prices)
        
        let chartViewModel = ChartViewModel(withChart: chart)
        
        XCTAssertEqual(chartViewModel.maxPriceString, "5.00")
    }
    
    func testStartAndEndDates() {
        let prices = [Price(value: 2, date: Date(timeIntervalSince1970: 0)),
                      Price(value: 3, date: Date(timeIntervalSince1970: 1)),
                      Price(value: 5, date: Date(timeIntervalSince1970: 2)),
                      Price(value: 1, date: Date(timeIntervalSince1970: 1502945501))]
        
        let chart = Chart(prices: prices)
        
        let chartViewModel = ChartViewModel(withChart: chart)
        
        // Depends on being in PST
        
        XCTAssertEqual(chartViewModel.startDate, "Dec 31, 1969")
        XCTAssertEqual(chartViewModel.endDate, "Aug 16, 2017")

    }
    
    func testLineHasMaxPoints() {
        let chartWithAFewPoints = makeChart(withNumberOfPrices: 9)
        let chartViewModelWithAFewPoints = ChartViewModel(withChart: chartWithAFewPoints)
        XCTAssertEqual(chartViewModelWithAFewPoints.line.count, 9)
    }
    
    private func makeChart(withNumberOfPrices numPrices: Int) -> Chart {
        var prices: [Price] = []
        for num in 1...numPrices {
            prices.append(Price(value: Double(num), date: Date(timeIntervalSince1970: Double(num))))
        }
        return Chart(prices: prices)
    }
}
