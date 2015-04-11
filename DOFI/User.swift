//
//  User.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

//
// The User class, representing af user.
//
public class User {

	private var id:NSInteger = -1

	private var username:NSString = ""

	private let name:NSString

	private let surname:NSString = ""

	private var token:Token?

	init(name: NSString, surname: NSString) {
		self.name = name
		self.surname = surname
	}

	init(id: NSInteger, name: NSString, surname: NSString) {
		self.id = id
		self.name = name
		self.surname = surname
	}

	//
	// Returns a users id
	//
	// :Returns: user id
	public func getId() -> NSInteger {
		return self.id
	}

	//
	//	Get a users obserkode.
	//
	// :Returns: Obserkode - A users obserkode
	public func getUsername () -> NSString {
		return self.username
	}

	//
	//	Get a users name.
	//
	// :Returns: Name - A users name
	public func getName () -> NSString {
		return self.name
	}

	//
	//	Get a users surname.
	//
	// :Returns: Surname - A users Surname
	public func getSurname () -> NSString {
		return self.surname
	}

	//
	// Set a users id.
	//
	// :Param: Id The new id.
	public func setId(id:NSInteger) {
		self.id = id
	}

	//
	// Set a users id.
	//
	// :Param: Id The new id.
	public func setObserkode(username:NSString) {
		self.username = username
	}
}
