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

    let localStorageMapper = LocalStorageMapper()
    let observationMapper = ObservationLocalStorageMapper()
    let tripMapper = TripLocalStorageMapper()
    
    func storeObservation(trip: Trip, observation: Observation) -> ReturnMessage{
        
        observation.tripId = trip.id
        
        var returnMessage = observationMapper.storeObservation(observation)
        
        return returnMessage
    }
    
    func storeTrip(trip: Trip) -> ReturnMessage{
        
        
        var returnMessage = tripMapper.storeTrip(trip)
        
        return returnMessage
    }

    func getAllObjects() -> NSDictionary? {
        
        var trips = tripMapper.getAllTrips()
        var observations = observationMapper.getAllObservations()
        
        if (trips.count == 0 && observations.count == 0){
            return nil
        }
        
        var dictionary:NSDictionary = [
            "trips" : trips,
            "observations" : observations
        ]
        
        return dictionary
    }
    
	private func getAllObservations() -> [Observation] {
		return observationMapper.getAllObservations()
	}
    
    private func getAllTrips() -> [Trip]{
        return tripMapper.getAllTrips()
    }
    
    func deleteRLMObject(rlmObject: RLMObject) -> ReturnMessage {
        
        var returnMessage = localStorageMapper.deleteRLMObject(rlmObject)
        
        return returnMessage
    }
}