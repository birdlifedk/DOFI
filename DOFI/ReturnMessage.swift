//
//  ReturnMessage.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class ReturnMessage {
    let message:NSString
    let isDone:Bool
    
    let realmObjects:[RLMObject]?
    
    init(message: NSString, isDone: Bool, objects: [RLMObject]?) {
        self.message = message
        self.isDone = isDone
        self.realmObjects = objects
    }
}