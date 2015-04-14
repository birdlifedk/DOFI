//
//  CommunicationFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class CommunicationFacade {

    var strategyFactory = StrategyFactory()

	func login(username:NSString, password:NSString) {
		var storageStrategy = strategyFactory.getStorageStrategy()
        storageStrategy.login(username, password: password)
	}
}