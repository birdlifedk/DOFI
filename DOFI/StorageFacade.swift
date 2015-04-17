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

    func storeObservation(userId:NSInteger, tripId:NSInteger, observation:Observation) -> ReturnMessage{

		localStorage.store(observation)
		inMemory.store(observation)

		var returnMessage = ReturnMessage(message: "Failed", isDone: false)
        
        return returnMessage
    }

	func getAllObservations() -> RLMResults {
		return localStorage.getAllObservations()
	}

	func uploadContent() -> ReturnMessage {
		localStorage.uploadContent()
		return ReturnMessage(message: "msg", isDone: true)
	}
}