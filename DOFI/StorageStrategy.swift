//
//  StorageFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

protocol StorageStrategy {

	func login(username:NSString, password:NSString) -> ReturnMessage
    
    func storeObservation(userId:NSInteger, trip: Trip, observation: Observation) -> ReturnMessage
    
    func storeTrip(userId:NSInteger, trip: Trip) -> ReturnMessage
    
    func uploadContent()
    
    func getAllObservations() -> RLMResults
}