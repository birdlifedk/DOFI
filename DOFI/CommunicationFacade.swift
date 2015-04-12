//
//  CommunicationFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class CommunicationFacade {

	var webCommunication = WebCommunication()

	var gpsCommunication = GPSCommunication()

	func login(username:NSString, password:NSString) {
		webCommunication.login(username, password: password)
	}
}