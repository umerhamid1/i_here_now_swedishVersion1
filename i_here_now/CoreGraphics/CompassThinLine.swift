//
//  CompassThinLine.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-08.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import UIKit

class CompassThinLine: UIView {
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 4.0
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
        
        
        //We need to rorate them 30 degrees
        //72 Seems to be the number we are looking for
        
        //The width is 250
        //Half width is 125
        
        //Vertical Line
        
        //var sinus = sin(90.0 * M_PI / 180)
        //var cosinus = cos(90 * M_PI / 180)
        //var tangent = tan(90 * M_PI / 180)
        
        
        //Right Side Top
        var deg = 30.0;
        var xPos = cos(degrees: deg) * halfWidth
        var yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        deg = 60.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        //Right Side Bottomm
        deg = -30.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        deg = -60.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        
        //Left Side Top
        deg = 120.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        deg = 150.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        //Left Side Bottomm
        deg = -120.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        deg = -150.0;
        xPos = cos(degrees: deg) * halfWidth
        yPos = sin(degrees: deg) * halfHeight
        
        plusPath.move(to: CGPoint(
            x:halfWidth+xPos,
            y:halfHeight-yPos))
        
        plusPath.addLine(to: CGPoint(
            x: halfWidth,
            y: halfHeight))
        
        //set the stroke color
        //UIColor.white.setStroke()
        AppColors.shared.backgroundColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        
        
        
    }
}
