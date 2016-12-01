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
    
    private var lastPrice: Double?
    
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
            self.priceSource.source().storePrice(price.value)
            self.price.text = self.formatPrice(price.value)
            
            if let last = self.lastPrice {
                if last > price.value {
                    self.setBackgroundPositive(false)
                } else {
                    self.setBackgroundPositive(true)
                }
            } else {
                print("whoops")
            }
            
            self.completed()
        }
    }
    
    private func setBackgroundPositive(_ condition: Bool) {
        if condition {
            view.backgroundColor = UIColor.green
        } else {
            view.backgroundColor = UIColor.red
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

    private func formatPrice(_ price: Double) -> String {
        return String(format: "%.02f", price)
    }
}

