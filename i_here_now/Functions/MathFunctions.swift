//
//  MathFunctions.swift
//  One
//
//  Created by Jimmy Ersson on 2018-10-08.
//  Copyright © 2018 Eldstorm AB. All rights reserved.
//

import Foundation
import UIKit

// Swift 3:
func sin(degrees: Double) -> CGFloat {
    return CGFloat(__sinpi(degrees/180.0))
}

func cos(degrees: Double) -> CGFloat {
    return CGFloat(__cospi(degrees/180.0))
}
