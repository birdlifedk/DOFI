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

    var id = -1
    
    var tripId = -1
    
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
    
    func makeCopy() -> Observation{
        var observation = Observation()
        observation.id = self.id
        observation.origin = self.origin
        observation.species = self.species
        observation.quantity = self.quantity
        observation.primaryBehaviour = self.primaryBehaviour
        observation.secondaryBehaviour = self.secondaryBehaviour
        observation.direction = self.direction
        observation.time = self.time
        observation.sex = self.sex
        observation.age = self.age
        observation.suit = self.suit
        observation.note = self.note
        
        return observation
    }
}