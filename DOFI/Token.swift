//
//  Token.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

struct Token {

	var accessToken: NSString

	var refreshToken: NSString

	var expiresIn: Double = 0.0

	var creation: Double = 0.0

	var Timestamp: NSTimeInterval {
		get {
			return (NSDate().timeIntervalSince1970 * 1000)
		}
	}

	init(accessToken: NSString, refreshToken: NSString, expiresIn: Double) {
		self.accessToken = accessToken
		self.refreshToken = refreshToken
		self.expiresIn = expiresIn
		self.creation = Timestamp
	}

	func isValid() -> Bool {
		return ((self.creation + self.expiresIn) <= Timestamp)
	}

	func isInvalid() -> Bool {
		return ((self.creation + self.expiresIn) > Timestamp)
	}

}