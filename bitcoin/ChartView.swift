//
//  ChartView.swift
//  bitcoin
//
//  Created by Joel Klabo on 12/3/16.
//  Copyright © 2016 Joel Klabo. All rights reserved.
//

import UIKit

class ChartView: UIView {

    var chart: Chart? {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        
        guard let chart = chart else { return }
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let viewWidth = rect.size.width
        let viewHeight = rect.size.height
        
        let maxPrice = chart.prices.max()!
        let heightRatio = viewHeight / maxPrice - 0.05
        let xPerPrice = viewWidth / CGFloat(chart.prices.count - 1)

        let linePath = UIBezierPath()
        linePath.lineWidth = 1.0
        linePath.lineJoinStyle = .round
        
        for (index, price) in chart.prices.enumerated() {
            let currentX = CGFloat(index) * xPerPrice
            let currentY = viewHeight - (price * heightRatio)
            
            let currentPoint = CGPoint(x: currentX, y: currentY)
            
            if index == 0 {
                linePath.move(to: currentPoint)
            } else {
                linePath.addLine(to: currentPoint)
            }
            
            if (price == maxPrice) {
                
                let priceString = "$\(formatPrice(maxPrice))" as NSString
                
                let attributes: [String: AnyObject] = [
                    NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 14),
                    NSAttributedStringKey.strokeWidth.rawValue: 0 as AnyObject,
                    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white
                ]
                
                let maxPriceWidth: CGFloat = 70
                let maxPriceHeight: CGFloat = 20
                
                let maxPriceOrigin = CGPoint(x: currentPoint.x - maxPriceWidth, y: currentPoint.y - maxPriceHeight)
                let maxPriceRect = CGRect(origin: maxPriceOrigin, size: CGSize(width: maxPriceWidth, height: maxPriceHeight))
                
                UIColor.black.setFill()
                let maxPricePoint = UIBezierPath(roundedRect: maxPriceRect, cornerRadius: 4)
                maxPricePoint.fill()

                let priceSize = priceString.size(withAttributes: attributes)
                
                let priceHeightDifference = (maxPriceRect.size.height - priceSize.height) / 2
                let priceWidthDifference = (maxPriceRect.size.width - priceSize.width) / 2
                
                let priceRect = maxPriceRect.insetBy(dx: priceWidthDifference, dy: priceHeightDifference)
                
                priceString.draw(in: priceRect, withAttributes: attributes)
            }
        }
        
        let lastPrice = chart.prices.last!
        let farRightPoint = CGPoint(x: viewWidth, y: lastPrice)
        linePath.addLine(to: farRightPoint)
        
        let bottomRightPoint = CGPoint(x: viewWidth, y: viewHeight)
        linePath.addLine(to: bottomRightPoint)
        
        let bottomLeftPoint = CGPoint(x: 0, y: viewHeight)
        linePath.addLine(to: bottomLeftPoint)
        
        linePath.close()
        
        UIColor.black.setFill()
        linePath.fill()
    }
    
    private func formatPrice(_ price: CGFloat) -> String {
        return String(format: "%.02f", price)
    }
}
