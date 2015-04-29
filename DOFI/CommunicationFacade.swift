//
//  CommunicationFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation
import Realm

/// A way to communicate with different storages and location handlers
class CommunicationFacade {

    ///The factory responsible for choosing strategies for CommunicationFacade
    var strategyFactory = StrategyFactory()
    
    ///The strategy for storing data
    var storageStrategy:StorageStrategy
    ///The strategy for getting the location of the device
    var locationStrategy:LocationStrategy

    /**
        Initializes the CommunicationFacade with the strategies provided by the StrategyFactory
    */
    init(){
        storageStrategy = strategyFactory.getStorageStrategy()
        locationStrategy = strategyFactory.getLocationStrategy()
    }
    
    /**
        Log in a user
    
        :param: username - The user's user name
        :param: password - The user's password
    */
	func login(username:NSString, password:NSString) -> ReturnMessage{
        return storageStrategy.login(username, password: password)
	}
    
    /**
        Store Observation
        
        
    */
    func storeObservation(trip: Trip, observation: Observation) -> ReturnMessage{
        return storageStrategy.storeObservation(trip, observation: observation)
    }
    
    func storeBreedingPair(trip: Trip, breadingPair: BreadingPair) -> ReturnMessage{
        
        return ReturnMessage(message: "", isSuccess: true)
    }
    
    func storeTrip(trip: Trip) -> ReturnMessage{
        return storageStrategy.storeTrip(trip)
    }
    
    func getLocation(locationManager: CLLocationManager) -> Location{
        locationManager.startUpdatingLocation()

        var location = locationStrategy.getLocation(locationManager)
        
        return location
    }

	func getTrips() -> NSDictionary {
		return storageStrategy.getAllLocalObjects()!
	}
    
    func uploadContent() -> ReturnMessage{
        return ReturnMessage(message: "", isSuccess: false)
    }
}