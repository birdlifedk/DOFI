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

    var storageStrategy:StorageStrategy
    
	var run = true

    init(storageStrategy: StorageStrategy){
        self.storageStrategy = storageStrategy
    }
    
	func start() {
		NSLog("Start")
		while run {

            sleep(5)
			uploadContent()
		}
	}

	func stop() {
		self.run = false
	}

	func getDbContent() {

	}

	func uploadContent() {
		storageStrategy.uploadContent()
	}
}