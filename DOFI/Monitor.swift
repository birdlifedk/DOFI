//
//  Monitor.swift
//  DOFI
//
//  Created by Andreas Dahl on 16/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class Monitor {

	var storage = StorageFacade()

	var run = true

	func start() {
		NSLog("Start")
		while run {

			uploadContent()
			sleep(5)

		}
	}

	func stop() {
		self.run = false
	}

	func getAllObservations() -> RLMResults {
		return storage.getAllObservations()
	}

	func getDbContent() {

	}

	func uploadContent() {
		storage.uploadContent()
	}
}