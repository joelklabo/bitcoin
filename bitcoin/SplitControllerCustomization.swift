//
//  SplitControllerCustomization.swift
//  bitcoin
//
//  Created by Joel Klabo on 11/30/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

extension UISplitViewController: UISplitViewControllerDelegate {
    
    // MARK: - user defined imlementation of UISplitViewControllerDelegate
    
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return false
    }
}
