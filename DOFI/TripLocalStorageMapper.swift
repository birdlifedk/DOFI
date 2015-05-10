//
//  TripLocalStorageMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class TripLocalStorageMapper: LocalStorageMapper {
    
    func storeTrip(trip: Trip) -> ReturnMessage{
        var tripCopy = trip.makeCopy()
        
        localStorage.store(trip)
        
        inMemoryStorage.store(tripCopy)
        
        return ReturnMessage(message: "Done storing trip", isSuccess: true)
    }
    
    func getAllTrips() -> [Trip]{
        var rlmTrips = localStorage.getAllTrips()
        
        var trips = [Trip]()
        
        var index = 0 as UInt
        var count = rlmTrips.count
        
        if (count >= 1){
            
            count = count - 1
            var ended = false
            
            while (!ended){
                var rlmObject: AnyObject! = rlmTrips.objectAtIndex(index)
                
                if (rlmObject.isKindOfClass(Trip)) {
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
        return trips
    }
}