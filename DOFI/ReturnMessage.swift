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
    let isSuccess:Bool
    
    let realmObjects:[RLMObject]?
    
    init(message: NSString, isSuccess: Bool, objects: [RLMObject]?) {
        self.message = message
        self.isSuccess = isSuccess
        self.realmObjects = objects
    }
    
    init(message: NSString, isSuccess: Bool) {
        self.message = message
        self.isSuccess = isSuccess
        self.realmObjects = nil
    }
}