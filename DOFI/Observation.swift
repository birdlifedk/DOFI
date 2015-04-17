//
//  Observation.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

struct Time {
	var from = "", to = ""
}

class Observation: RLMObject {

	var origin = Time()

	var species:NSString = ""

	var quantity:NSInteger = -1

	var primaryBehaviour:NSString = ""

	var secondaryBehaviour:NSString = ""

	var direction:NSString = ""

	var time: Time {
		get {
			let from = ""
			let to   = ""
			return Time(from: "", to: "")
		}
		set(newTime) {
			origin.from = newTime.from
			origin.to   = newTime.to
		}
	}

	var sex:NSString = ""

	var age:NSInteger = -1

	var suit:NSString = ""

	var note:NSString = ""


}