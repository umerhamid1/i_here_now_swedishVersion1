//
//  LanguageFunctions.swift
//  i_here_now
//
//  Created by Jimmy Ersson on 2018-10-13.
//  Copyright © 2018 Livheim AB. All rights reserved.
//

import Foundation

//Short Function To Get Strings For Different Languages
func str(_ str:String)->String{

    return NSLocalizedString(str, comment: "")
    
}
