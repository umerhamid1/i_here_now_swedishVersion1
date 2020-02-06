//
//  CustomSlideer.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-23.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import UIKit

class CustomSlideer: UIView {


    @IBOutlet weak var sliderLabelBackground: UIView!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    
    /*
    //For Future Project
    @objc func sliderValueDidChange(_ sender:UISlider!){
        
        print("I was sliding! He he")
        sliderLabel.text = "Heheh";
        
    }
    */
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    override func draw(_ rect: CGRect) {

        super.draw(rect)

        
        
    }
    
    func commonInit(){

        let myView = Bundle.main.loadNibNamed("CustomSlider", owner: self, options: nil)![0] as! UIView
       
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(myView)
        

        
        NSLayoutConstraint(item: myView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: myView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: myView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: myView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        
        //slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
    }
    
    
 
        
}
