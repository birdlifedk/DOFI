//
//  Session.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

struct Session {

	private static var trip:Trip? = nil

	private static var loggedIn = false

	private static var user:User?

	static func getUser() -> User {
		return self.user!
	}

	static func getTrip() -> Trip? {
		return self.trip
	}

	static func isLoggedIn() -> Bool {
		return self.loggedIn
	}

	static func setLoggedInStatus(status: Bool) {
		self.loggedIn = status
	}

	static func setUser(user: User) {
		self.user = user
	}

	static func setTrip(trip: Trip) {
		self.trip = trip
	}
}