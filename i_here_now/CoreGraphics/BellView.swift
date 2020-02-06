//
//  BellView.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-22.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class BellView: UIImageView {


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
        
        //self.backgroundColor = UIColor.red //Background Color

        
    }
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        
        
        super.draw(rect)
        
        
        
        //setAnchorPoint(anchorPoint: CGPoint(x:0, y:0), view: self)
        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle * .pi / 180))
        
        
        
    }
    
    
    
    
}
