//
//  LocalStorageFacade.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
class StorageFacade {
    func storeObservation(userId:NSInteger, trip: Trip, observation:Observation) -> ReturnMessage{

		var returnMessage = ReturnMessage(message: "Failed", isDone: false, objects: nil)
        
        return returnMessage
    }
}