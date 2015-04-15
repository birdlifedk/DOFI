//
//  Webservice.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

protocol WebserviceProtocol {

	func login(username: NSString, password: NSString) -> ReturnMessage
    
    func storeObservation(userId: NSInteger, tripId: NSInteger, observation: Observation) -> ReturnMessage
}