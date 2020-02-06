//
//  TestData.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-05.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import Foundation

open class TestData{
    
    public static let shared:TestData = TestData()
    
    public func test(name:String){
        
        print("Hello World "+name+"!")
        
        
    }
    
}

/*
 #if en
 
 print("EN")
 
 #elseif sv
 
 print("SV")
 
 #endif
 */
