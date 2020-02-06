//
//  ChartView.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-10.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

@IBDesignable class ChartView: UIView {
        
        private struct Constants {
            static let numberOfGlasses = 8
            static let lineWidth: CGFloat = 5.0
            //static let arcWidth: CGFloat = 76
            static let arcWidth: CGFloat = 110
            
            static var halfOfLineWidth: CGFloat {
                return lineWidth / 2
            }
        }
    
    
        @IBInspectable var counter: Int = 5
        @IBInspectable var outlineColor: UIColor = UIColor.blue
        @IBInspectable var counterColor: UIColor = UIColor.orange
        
        @IBInspectable var startAngle: CGFloat = .pi/2
        @IBInspectable var endAngle: CGFloat = .pi
        
        override func draw(_ rect: CGRect) {
            
            // 1 Pivot Point
            let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
            
            // 2 Make the maximum dimension in the view
            let radius: CGFloat = max(bounds.width, bounds.height)
            
            // 3 The Start and End ANgle of the arc
            //let startAngle: CGFloat = 4 * .pi / 4
            // let startAngle: CGFloat = .pi/2
            //let endAngle: CGFloat = .pi
            //let endAngle: CGFloat = .pi / 4
            
            // 4 Create a path based on the center point, radius, and angles
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius/2 - Constants.arcWidth/2,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            
            // 5 Set the line width and color before finally stroking the path
            path.lineWidth = Constants.arcWidth
            
            
            
            
            //Stroe is dwaring the path
            counterColor.setStroke()
            
            path.stroke()
            
            
            
            //Draw the outline
            
            /*
             //1 - first calculate the difference between the two angles
             //ensuring it is positive
             let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
             //then calculate the arc for each single glass
             let arcLengthPerGlass = angleDifference / CGFloat(Constants.numberOfGlasses)
             //then multiply out by the actual glasses drunk
             let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
             
             //2 - draw the outer arc
             let outlinePath = UIBezierPath(arcCenter: center,
             radius: bounds.width/2 - Constants.halfOfLineWidth,
             startAngle: startAngle,
             endAngle: outlineEndAngle,
             clockwise: true)
             
             //3 - draw the inner arc
             outlinePath.addArc(withCenter: center,
             radius: bounds.width/2 - Constants.arcWidth + Constants.halfOfLineWidth,
             startAngle: outlineEndAngle,
             endAngle: startAngle,
             clockwise: false)
             
             //4 - close the path
             outlinePath.close()
             
             outlineColor.setStroke()
             outlinePath.lineWidth = Constants.lineWidth
             outlinePath.stroke()
             */
            
            
        }

    
}
