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
		while run {
            if (Session.sharedInstance.isLoggedIn()){
            
                uploadContent()
                sleep(5)
                
            }else{
                println("Monitor: User not logged in")
                println(Session.sharedInstance)
                sleep(10)
            }
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