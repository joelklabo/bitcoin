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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastPrice = priceSource.source().lastPrice()
        
        if let storedPrice = lastPrice {
            self.currentPrice.text = formatPrice(storedPrice)
        }

        priceSource.source().currentPrice { price in
            self.priceSource.source().storePrice(price)
            self.currentPrice.text = self.formatPrice(price)
        }        
    }

    @IBAction func chartRangeUpdate(_ sender: Any) {
        if let control = sender as? UISegmentedControl {
            guard let chartRange = ChartRange(rawValue: control.selectedSegmentIndex) else {
                fatalError()
            }
            BlockchainChartClient().chartFor(chartRange) { chart in
                self.chartView.chart = chart
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func formatPrice(_ price: CGFloat) -> String {
        return String(format: "%.02f", price)
    }

}
