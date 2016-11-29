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
        
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                fatalError()
            }
            guard let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                fatalError()
            }
            guard let prices = json["bpi"] as? [String: Any] else {
                fatalError()
            }
            guard let USDInfo = prices["USD"] as? [String: Any] else {
                fatalError()
            }
            guard let rate = USDInfo["rate"] as? String else {
                fatalError()
            }
            guard let USDPrice = Double(rate) else {
                fatalError()
            }
            DispatchQueue.main.async {
                self.completed()
                self.price.text = String(format: "%.02f", USDPrice)
            }
        }
        
        task.resume()
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

