//
//  LocalStorageStrategy.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class LocalStorageStrategy: StorageStrategy {

    let localStorageFacade = StorageFacade()
    let dofiService = DOFIService()
    
	func login(username: NSString, password: NSString) -> ReturnMessage{
        var connection = Reachability.reachabilityForInternetConnection()
        
        if(connection.isReachableViaWiFi()) {
            return dofiService.login(username, password: password)
        }
        else{
            return ReturnMessage(message: "Det ser ud til du ikke har forbindelse til internettet", isDone: false, objects: [])
        }
        
	}
    
    func storeObservation(userId:NSInteger, trip: Trip, rlmObject: RLMObject) -> ReturnMessage{
        return localStorageFacade.storeObservation(userId, trip: trip, rlmObject: rlmObject)
    }
}