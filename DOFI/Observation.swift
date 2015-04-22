//
//  Observation.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class Observation: RLMObject {

	var species:NSString = ""

	var quantity:NSInteger = -1

	var primaryBehaviour:NSString = ""

	var secondaryBehaviour:NSString = ""

	var direction:NSString = ""

	var time: Time?

	var sex:NSString = ""

	var age:NSInteger = -1

	var suit:NSString = ""

	var note:NSString = ""
	
	
}