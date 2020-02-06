//
//  BuildConfig.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-10.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import Foundation


enum Language {
    case Eng
    case Swe
}

class BuildConfig {
    
    static var currentLanguage: Language {
        
        get {
            
            #if en
            
            return Language.Eng
            
            #elseif sv
            
            return Language.Swe
            
            #endif
            
        }
        
    }
    
}
