//
//  DOFIInMemoryStorage.swift
//  DOFI
//
//  Created by Andreas Dahl on 15/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class DOFIInMemoryStorage {

	let realm =  RLMRealm.inMemoryRealmWithIdentifier("DOFIMemory")

	func store(object: RLMObject) {
		self.realm.addObject(object)
	}

	func delete(object: RLMObject) {
		self.delete(object)

	}
}