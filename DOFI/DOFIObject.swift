//
//  DOFIObject.swift
//  DOFI
//
//  Created by Rasmus Rosted on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

protocol DOFIObject{
    func makeCopy() -> RLMObject
    
    func validate() -> ReturnMessage
}