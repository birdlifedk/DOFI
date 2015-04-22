//
//  TripMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class TripMapper: Mapper {
    
    func getTrips() -> [Trip]
    {
        var jsonData = webserviceAPICommunication.getTripsAsJSONDictionary()
        
        var trips = [Trip(), Trip()] as [Trip]
        
        return trips
    }
    
    func uploadContent(rlmResults: RLMResults) -> ReturnMessage{
        
        var trips = [Trip]()
        var observations = [Observation]()
        
        var index = 0 as UInt
        var count = rlmResults.count - 1
        
        if (count >= 0){
            
            var ended = false
        
            while (!ended){
                var rlmObject = rlmResults.objectAtIndex(index)
            
                if (rlmObject.isKindOfClass(Observation)){
                    var observation = rlmObject as! Observation
                    
                    println(observation)
                    
                    observations.append(observation)
                } else if (rlmObject.isKindOfClass(Trip)) {
                    var trip = rlmObject as! Trip
                    
                    println(trip)
                    
                    trips.append(trip)
                }
                
                
                if (index==count){
                    ended = true
                }
                index++
            }
        }
        
        var dictionary:NSDictionary = [
            "trips" : trips,
            "observations" : observations
        ]
        
        return webserviceAPICommunication.uploadContent(dictionary)
    }
}