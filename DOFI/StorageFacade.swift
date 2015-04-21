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
    func storeObservation(userId:NSInteger, trip: Trip, rlmObject: RLMObject) -> ReturnMessage{

		var returnMessage = ReturnMessage(message: "Failed", isDone: false, objects: nil)
        
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