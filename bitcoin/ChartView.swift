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
        guard let _ = UIGraphicsGetCurrentContext() else {
            return
        }

        let viewWidth = rect.size.width
        let viewHeight = rect.size.height
        
        let maxPrice = chart.prices.max()!
        let heightRatio = viewHeight / maxPrice - 0.03
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
                UIColor.magenta.setFill()
                let maxPricePoint = UIBezierPath(arcCenter: currentPoint, radius: 10, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
                maxPricePoint.fill()
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

}
