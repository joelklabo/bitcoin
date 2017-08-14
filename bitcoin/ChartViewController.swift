//
//  ChartViewController.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/3/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    let priceSource = PriceClientSource.blockchain
    
    private var lastPrice: CGFloat?
    
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let becameActiveNotification = NSNotification.Name.UIApplicationDidBecomeActive
        NotificationCenter.default.addObserver(self, selector: #selector(updatePrice), name: becameActiveNotification, object: nil)
        activityIndicator.hidesWhenStopped = true
        updateChart(.oneMonth)
        segmentedControl.selectedSegmentIndex = ChartRange.oneMonth.rawValue
    }

    @IBAction func chartRangeUpdate(_ sender: Any) {
        if let control = sender as? UISegmentedControl {
            guard let chartRange = ChartRange(rawValue: control.selectedSegmentIndex) else {
                fatalError()
            }
            updateChart(chartRange)
        }
    }
    
    private func updateChart(_ range: ChartRange) {
        activityIndicator.startAnimating()
        BlockchainChartClient().chartFor(range) { chart in
            self.activityIndicator.stopAnimating()
            self.chartView.chart = chart
        }
    }
    
    @objc dynamic private func updatePrice() {
        lastPrice = priceSource.source().lastPrice()
        
        if let storedPrice = lastPrice {
            self.currentPrice.text = formatPrice(storedPrice)
        }
        activityIndicator.startAnimating()
        priceSource.source().currentPrice { price in
            self.activityIndicator.stopAnimating()
            self.priceSource.source().storePrice(price)
            self.currentPrice.text = self.formatPrice(price)
        }
    }

    private func formatPrice(_ price: CGFloat) -> String {
        return String(format: "%.02f", price)
    }

}
