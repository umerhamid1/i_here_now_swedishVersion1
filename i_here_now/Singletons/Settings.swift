//
//  Settings.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-20.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import Foundation
open class Settings{
    
    public static let shared:Settings = Settings()
   
    public var languageCode:String = "en"

    
    public func setLanguage(lang:String){
        
        languageCode = lang
        
    }
    
    public func getLanguage()->String{
        
        if languageCode == "en"{
            
            return "en"
            
        }else{
        
            return "sv"
            
        }

        
    }
    
    /*
    public func getLanguage()->String{
        
         #if en
         
            return "en"
         
         #elseif sv
         
            return "sv"
         
         #endif
        
    }
     */
    
}


