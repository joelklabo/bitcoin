//
//  ViewController.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/28/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func updatePrice() {
        
        loading()
        
        CoinbaseClient.currentPrice { price in
            self.completed()
            self.price.text = String(format: "%.02f", price.value)
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

    override func viewDidLoad() {
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePrice), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @IBAction func doubleTap(_ sender: Any) {
        updatePrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updatePrice()
    }

}

