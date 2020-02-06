//
//  AppColors.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-22.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import Foundation
import UIKit



open class AppColors{

public static let shared:AppColors = AppColors()

    
    public func backgroundColor()->UIColor{

        //return UIColor(displayP3Red: 31/255, green: 153/255, blue: 169/255, alpha: 1)
         return UIColor(displayP3Red: 125/255, green: 214/255, blue: 191/255, alpha: 1)
        
    }
    
    public func ColorOne()->UIColor{
        
       //return UIColor(displayP3Red: 7/255, green: 36/255, blue: 40/255, alpha: 1)
        return UIColor(displayP3Red: 59/255, green: 214/255, blue: 187/255, alpha: 1)
    }
    
    public func ColorTwo()->UIColor{
        
        //return UIColor(displayP3Red: 10/255, green: 59/255, blue: 75/255, alpha: 1)
        return UIColor(displayP3Red: 56/255, green: 206/255, blue: 214/255, alpha: 1)
        
        
    }
    
    public func ColorThree()->UIColor{
       
        //Left Bottom
        //return UIColor(displayP3Red: 12/255, green: 81/255, blue: 90/255, alpha: 1)
        //return UIColor(displayP3Red: 51/255, green: 214/255, blue: 183/255, alpha: 1)
        return UIColor(displayP3Red: 32/255, green: 196/255, blue: 165/255, alpha: 1)
        
        
    }
    
    public func ColorFour()->UIColor{
        
        //Left Pie Up
        //return UIColor(displayP3Red: 16/255, green: 101/255, blue: 112/255, alpha: 1)
        //return UIColor(displayP3Red: 127/255, green: 214/255, blue: 203/255, alpha: 1)
        return UIColor(displayP3Red: 115/255, green: 185/255, blue: 193/255, alpha: 1)
        
     
    }

    public func ColorFive()->UIColor{
        
        //return UIColor(displayP3Red: 23/255, green: 123/255, blue: 136/255, alpha: 1)
        return UIColor(displayP3Red: 66/255, green: 188/255, blue: 167/255, alpha: 1)
        
        
    }
    
}
