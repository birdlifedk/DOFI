//
//  WebCommunication.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class WebCommunication {

	let strategyFacade:StrategyFacade = StrategyFacade()

	func login(username:NSString, password:NSString) {
		strategyFacade.login(username, password: password)
	}
}