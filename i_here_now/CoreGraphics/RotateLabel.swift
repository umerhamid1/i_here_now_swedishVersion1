//
//  RotateLabel.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-09.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import UIKit

@IBDesignable class RotateLabel: UILabel {
    
    /*
     func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
     var newPoint = CGPoint(x:view.bounds.size.width * anchorPoint.x, y:view.bounds.size.height * anchorPoint.y)
     var oldPoint = CGPoint(x:view.bounds.size.width * view.layer.anchorPoint.x, y:view.bounds.size.height * view.layer.anchorPoint.y)
     
     newPoint = newPoint.applying(view.transform)
     oldPoint = oldPoint.applying(view.transform)
     
     var position : CGPoint = view.layer.position
     
     position.x -= oldPoint.x
     position.x += newPoint.x;
     
     position.y -= oldPoint.y;
     position.y += newPoint.y;
     
     view.layer.position = position;
     view.layer.anchorPoint = anchorPoint;
     }
     */
    @IBInspectable var angle: Double = 0
    
    
    //It's possible I need this when I do everything from Code
    
     override init(frame: CGRect) {
     
        super.init(frame: frame)
     
        config()
     
     }
     
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        config()
     
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        config()
    }
    
    
    func config(){
        
        self.textColor = UIColor.white //Set Standard Color
        self.backgroundColor = UIColor.clear //Background Color
        
        self.font = self.font.withSize(10) //Set Standard Font Size
        self.adjustsFontSizeToFitWidth = false
        
    }
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        
        
        
        
        super.drawText(in: rect)
        
        //setAnchorPoint(anchorPoint: CGPoint(x:0, y:0), view: self)
        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle * .pi / 180))
        
        
        
    }
    
    
    
    
}
