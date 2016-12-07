//
//  PriceViewController.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/28/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController, UISplitViewControllerDelegate {
    
    // Set the default client
    var priceSource: PriceClientSource = .coinbase
    
    private var lastPrice: CGFloat?
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = priceSource.displayName()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastPrice = priceSource.source().lastPrice()
        if let storedPrice = lastPrice {
            self.price.text = formatPrice(storedPrice)
        }
        updatePrice()
    }
    
    func updatePrice() {
        loading()
        priceSource.source().currentPrice { price in
            self.priceSource.source().storePrice(price)
            self.price.text = self.formatPrice(price)
            self.completed()
        }
    }
    
    
    private func loading() {
        price.alpha = 0.3
        spinner.startAnimating()
    }
    
    private func completed() {
        self.spinner.stopAnimating()
        price.alpha = 1.0
    }

    private func formatPrice(_ price: CGFloat) -> String {
        return String(format: "%.02f", price)
    }
}

