//
//  File.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class OnlineStorageStrategy: StorageStrategy {

	let dofiService = DOFIService()

	func login(username: NSString, password: NSString) {
		dofiService.login(username, password: password)
	}
}