//
//  ObservationLocalStorageMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class ObservationLocalStorageMapper: LocalStorageMapper {
    func storeObservation(observation: Observation) -> ReturnMessage{
        var observationCopy = observation.makeCopy()
        
        localStorage.store(observation)
        
        inMemoryStorage.store(observationCopy)
        
        return ReturnMessage(message: "Done storing observation", isDone: true)
    }
    
    func getAllObservations() -> [Observation]{
        var rlmObservations = localStorage.getAllObservations()
        
        var observations = [Observation]()
        
        var index = 0 as UInt
        var count = rlmObservations.count - 1
        
        if (count >= 0){
            
            var ended = false
            
            while (!ended){
                var rlmObject = rlmObservations.objectAtIndex(index)
                
                if (rlmObject.isKindOfClass(Observation)){
                    var observation = rlmObject as! Observation
                    
                    println(observation)
                    
                    observations.append(observation)
                }
                
                if (index==count){
                    ended = true
                }
                index++
            }
        }
        return observations
    }
}