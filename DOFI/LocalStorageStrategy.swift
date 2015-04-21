//
//  LocalStorageStrategy.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit
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
            var alert = UIAlertView()
            alert.title = "Ingen internet?"
            alert.message = "Det ser ud til du ikke har forbindelse til internettet"
            alert.addButtonWithTitle("Ok")
            alert.show()
            var returnMessage = ReturnMessage(message: "Det ser ud til du ikke har forbindelse til internettet", isDone: false, objects: [])
            
            return (returnMessage)
        }
        
	}
    
    func storeObservation(userId:NSInteger, trip: Trip, observation:Observation) -> ReturnMessage{
        return localStorageFacade.storeObservation(userId, trip: trip, observation: observation)
    }
}