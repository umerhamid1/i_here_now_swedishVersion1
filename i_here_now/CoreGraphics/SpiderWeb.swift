//
//  SpiderWeb.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-09.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import UIKit

@IBDesignable class SpiderWeb: UIView {
    
    @IBInspectable var dot_1_value: CGFloat = 1
    @IBInspectable var dot_2_value: CGFloat = 0.9
    @IBInspectable var dot_3_value: CGFloat = 0.8
    @IBInspectable var dot_4_value: CGFloat = 0.7
    @IBInspectable var dot_5_value: CGFloat = 0.6
    @IBInspectable var dot_6_value: CGFloat = 0.5
    @IBInspectable var dot_7_value: CGFloat = 0.5
    @IBInspectable var dot_8_value: CGFloat = 0.6
    @IBInspectable var dot_9_value: CGFloat = 0.7
    @IBInspectable var dot_10_value: CGFloat = 0.8
    @IBInspectable var dot_11_value: CGFloat = 0.9
    @IBInspectable var dot_12_value: CGFloat = 1
    
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 2.5
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    func makeDot(xCoord:CGFloat,yCoord:CGFloat){
        
        // let xCoord = 10
        // let yCoord = 20
        let radius = 10
        
        let dotPath = UIBezierPath(ovalIn: CGRect(x:CGFloat(xCoord), y:CGFloat(yCoord), width:CGFloat(radius), height:CGFloat(radius)))
        
        
        
        let layer = CAShapeLayer()
        layer.path = dotPath.cgPath
        //layer.strokeColor = AppColors.shared.ColorOne().cgColor
        layer.strokeColor = UIColor.white.cgColor
        //layer.fillColor = AppColors.shared.ColorOne().cgColor
        layer.fillColor = UIColor.white.cgColor
        
        //UIColor.blue.setFill()
        
        self.layer.addSublayer(layer)
        
    }
    
    
    func createDot(path:UIBezierPath, degrees:Double){
        
        var value:CGFloat = 0
        
        switch degrees{
            
        case 15:
            value = dot_1_value
            break
            
        case 45:
            value = dot_2_value
            break
            
        case 75:
            value = dot_3_value
            break
            
        case 105:
            value = dot_4_value
            break
            
        case 135:
            value = dot_5_value
            break
            
        case 165:
            value = dot_6_value
            break
            
        case 195:
            value = dot_7_value
            break
            
        case 225:
            value = dot_8_value
            break
            
        case 255:
            value = dot_9_value
            break
            
        case 285:
            value = dot_10_value
            break
            
        case 315:
            value = dot_11_value
            break
            
        case 345:
            value = dot_12_value
            break
            
            
        default:
            print("No Index")
        }
        
        
        
        let zeroValue:CGFloat = 110
        
        //Reverse The value That's Why it's 1
        let circleValue:CGFloat = (1-value)*zeroValue
        
        
        let xPos = bounds.width/2 + cos(degrees: degrees) * (bounds.width/2 - circleValue)
        let yPos = bounds.width/2 + sin(degrees: degrees) * (bounds.height/2 - circleValue)
        
        if degrees == 15{
            path.move(to: CGPoint(
                x:xPos,
                y:yPos))
        }
        
        path.addLine(to: CGPoint(
            x: xPos,
            y: yPos))
        
        
        //Last Line back to Start again
        if degrees == 345{
            
            let firstDegree:Double = 15
            let circleValue2:CGFloat = (1-dot_1_value)*zeroValue
            
            let xPos1 = bounds.width/2 + cos(degrees: firstDegree) * (bounds.width/2 - circleValue2)
            let yPos1 = bounds.width/2 + sin(degrees: firstDegree) * (bounds.height/2 - circleValue2)
            
            path.addLine(to: CGPoint(
                x: xPos1,
                y: yPos1))
            
        }
        
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
        var deg = 20.0;
        var xPos = cos(degrees: deg) * halfWidth
        var yPos = sin(degrees: deg) * halfHeight
        
        //Debug
        
        xPos = 50
        yPos = 50
        
        /*
         plusPath.move(to: CGPoint(
         x:50,
         y:50))
         */
        
        /*
         plusPath.addLine(to: CGPoint(
         x: 100,
         y: 50))
         */
        
        // plusPath.move(to: CGPoint(
        //   x:100,
        //  y:0))
        
        
        //We need to chnage bouncs/2 to a value between 1 = 0 and 10 = 1
        //It will resolve in width/2 * 0 to 1
        
        //Start here now when we do programing tomorrow or sunday
        //This is the Forumla
        
        /*
         let degrees = 15.0
         let xPos1 = bounds.width/2 + cos(degrees: degrees) * (bounds.width/2 - 50)
         let yPos1 = bounds.width/2 + sin(degrees: degrees) * (bounds.height/2 - 50)
         
         
         
         plusPath.addLine(to: CGPoint(
         x: xPos1,
         y: yPos1))
         */
        
        
        
        
        createDot(path: plusPath, degrees: 15)
        
        createDot(path: plusPath, degrees: 45)
        
        createDot(path: plusPath, degrees: 75)
        
        createDot(path: plusPath, degrees: 105)
        
        createDot(path: plusPath, degrees: 135)
        
        createDot(path: plusPath, degrees: 165)
        
        createDot(path: plusPath, degrees: 195)
        
        createDot(path: plusPath, degrees: 225)
        
        createDot(path: plusPath, degrees: 255)
        
        createDot(path: plusPath, degrees: 285)
        
        createDot(path: plusPath, degrees: 315)
        
        createDot(path: plusPath, degrees: 345)
        
        
        /*
         plusPath.addLine(to: CGPoint(
         x: 50,
         y: 100))
         
         //Back to start again
         plusPath.addLine(to: CGPoint(
         x: 50,
         y: 50))
         */
        
        
        
        
        
        //set the stroke color
        //UIColor.blue.setStroke()
        //AppColors.shared.ColorOne().setStroke()
        UIColor.white.setStroke()
        
        //Fill Color
        //let color = AppColors.shared.ColorOne().withAlphaComponent(1)
        //AppColors.shared.ColorOne().setFill()
        UIColor.white.setFill()
        
        
        plusPath.lineCapStyle = .square //Without this we have a missing Pixel on the border
        
        //draw the stroke
        //plusPath.stroke()
        plusPath.stroke(with: .normal, alpha: 0.75)
        
        //plusPath.fill()
        plusPath.fill(with: .normal, alpha: 0.5)
        
        
        //makeDot(xCoord: 45, yCoord: 45)
        
        
        
    }
}
