//
//  Session.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

struct Session {

	private static var loggedIn = false

	private static var user:User?
    
    private static var token:Token?

	static func getUser() -> User {
		return self.user!
	}
    
    static func getToken() -> Token {
        return self.token!
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
    
    static func setToken(token: Token) {
        self.token = token
    }
}