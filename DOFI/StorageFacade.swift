//
//  LocalStorageFacade.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class StorageFacade {

	let inMemory = DOFIInMemoryStorage()
	let localStorage = DOFILocalStorage()

    func storeObservation(userId:NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        
        var observationCopy = observation.makeCopy()
        
        localStorage.store(observation)
        
        inMemory.store(observationCopy)
        
        var returnMessage = ReturnMessage(message: "Done storing observation", isDone: true)
        
        return returnMessage
    }
    
    func storeTrip(userId:NSInteger, trip: Trip) -> ReturnMessage{
        var tripCopy = trip.makeCopy()
        
        localStorage.store(trip)
        
        inMemory.store(tripCopy)
        
        var returnMessage = ReturnMessage(message: "Done storing trip", isDone: true)
        
        return returnMessage
    }

	func getAllObservations() -> RLMResults {
		return localStorage.getAllObservations()
	}
    
    func deleteRLMObject(rlmObject: RLMObject) -> ReturnMessage {
        localStorage.delete(rlmObject)
        
        var returnMessage = ReturnMessage(message: "Done deleting", isDone: true)
        
        return returnMessage
    }
}