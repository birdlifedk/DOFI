//
//  StrategyFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class StrategyFacade {

	var strategy: StorageStrategy? = nil

	func determineStrategy() {
		var connection = Reachability.reachabilityForInternetConnection()

		if(connection.isReachableViaWiFi()) {
			self.strategy = OnlineStorageStrategy()
		} else {
			self.strategy = LocalStorageStrategy()
		}
	}

	func login(username:NSString, password:NSString) {
		self.determineStrategy()
		self.strategy?.login(username, password: password)
	}

}