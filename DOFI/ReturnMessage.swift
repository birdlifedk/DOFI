//
//  ReturnMessage.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
class ReturnMessage {
    let message:NSString
    let isDone:Bool
    
    init(message: NSString, isDone: Bool) {
        self.message = message
        self.isDone = isDone
    }
}