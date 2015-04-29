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
            return ReturnMessage(message: "Det ser ud til du ikke har forbindelse til internettet", isSuccess: false, objects: [])
        }
        
	}
    
    func storeObservation(trip: Trip, observation: Observation) -> ReturnMessage{
        return localStorageFacade.storeObservation(trip, observation: observation)
    }
    
    func storeTrip(trip: Trip) -> ReturnMessage{
        return localStorageFacade.storeTrip(trip)
    }
    
    func uploadContent(){
        println("Monitoring!")
        
        if(connection.isReachableViaWiFi()) {
            var objectDictionary = getAllLocalObjects()
            
            println(objectDictionary)
            
            if (objectDictionary != nil){
                var returnMessage = dofiService.uploadContent(objectDictionary!)
                
                println(returnMessage.message)
                
                if (returnMessage.isSuccess){
                    println("Ended uploading.. deleting locally?")
                    //delete something
                }
                
            }
        
        }
        
    }
    
    func getAllLocalObjects() -> NSDictionary?{
        return localStorageFacade.getAllObjects()
    }
    
    func deleteRLMObject(rlmObject: RLMObject) -> ReturnMessage {
        return localStorageFacade.deleteRLMObject(rlmObject)
    }
}