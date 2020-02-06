//
//  CompassThickLine.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-08.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import UIKit

class CompassThickLine: UIView {
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 10.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        //set up the width and height variables
        //for the horizontal stroke
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.plusLineWidth
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x: 0,
            y: halfHeight))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x: bounds.width,
            y: halfHeight))
        
        //Vertical Line
        
        plusPath.move(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: 0))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth + Constants.halfPointShift,
            y: bounds.height))
        
        
        
        //set the stroke color
        //UIColor.white.setStroke()
        
        AppColors.shared.backgroundColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        
        
    }
}

