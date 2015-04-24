//
//  Session.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

 class Session {

	private var trip:Trip? = nil

	private var loggedIn = false

	private var user:User?
    
    private var token:Token?
    
    private init() {}
    
	func getUser() -> User {
		return self.user!
	}
    
    func getToken() -> Token {
        return self.token!
    }

	func getTrip() -> Trip? {
		return self.trip
	}

	func isLoggedIn() -> Bool {
		return self.loggedIn
	}

	func setLoggedInStatus(status: Bool) {
		self.loggedIn = status
	}

	func setUser(user: User) {
		self.user = user
	}

	func setTrip(trip: Trip) {
		self.trip = trip
	}
    
    func setToken(token: Token) {
        self.token = token
    }
    
    class var sharedInstance :Session {
        
        struct Singleton {
            static let instance = Session()
        }
        
        return Singleton.instance
    }
}