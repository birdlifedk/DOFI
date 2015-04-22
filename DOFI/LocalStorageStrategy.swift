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
    let connection = Reachability.reachabilityForInternetConnection()
    
	func login(username: NSString, password: NSString) -> ReturnMessage{
        
        if(connection.isReachableViaWiFi()) {
            return dofiService.login(username, password: password)
        }
        else{
            return ReturnMessage(message: "Det ser ud til du ikke har forbindelse til internettet", isDone: false, objects: [])
        }
        
	}
    
    func storeObservation(userId:NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        return localStorageFacade.storeObservation(userId, trip: trip, observation: observation)
    }
    
    func uploadContent(){
        println("Monitoring!")
        
        if(connection.isReachableViaWiFi()) {
            var rlmResults = getAllObservations()
            println("Number of observations: " + rlmResults.count.description)
            
            if (rlmResults.count>0){
                var returnMessage = dofiService.uploadContent(rlmResults)
                
                println(returnMessage.message)
                
                if (returnMessage.isDone){
                    println("Upload was successful")
                    //Something here
                }
                
            }
        
        }
        
    }
    
    func getAllObservations() -> RLMResults {
        return localStorageFacade.getAllObservations()
    }
}