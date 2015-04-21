//
//  DOFILocalStorage.swift
//  DOFI
//
//  Created by Andreas Dahl on 15/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class DOFILocalStorage {

	let realm =  RLMRealm.defaultRealm()

	func store(object: RLMObject) {
		self.realm.addObject(object)
	}

	func delete(object: RLMObject) {
		self.delete(object)
	}

	func getAllObservations() -> RLMResults {
		return Observation.allObjects()
	}
}