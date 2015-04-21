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
    var storageStrategy:StorageStrategy?
    ///The strategy for getting the location of the device
    var locationStrategy:LocationStrategy?

    /**
        Initializes the CommunicationFacade with the strategies provided by the StrategyFactory
    */
    init(){
        storageStrategy = nil
        locationStrategy = nil
    }
    
    /**
        Log in a user
    
        :param: username - The user's user name
        :param: password - The user's password
    */
	func login(username:NSString, password:NSString) -> ReturnMessage{
		getStorageStrategy()
        return storageStrategy!.login(username, password: password)
	}
    
    /**
        Store Observation
        
        
    */
    func storeObservation(userId:NSInteger, trip: Trip, rlmObject: RLMObject) -> ReturnMessage{
        getStorageStrategy()
        return storageStrategy!.storeObservation(userId, trip: trip, rlmObject: rlmObject)
    }
    
    func getLocation(locationManager: CLLocationManager) -> Location{
        locationManager.startUpdatingLocation()
        getLocationStrategy()
        
        
        var location = locationStrategy!.getLocation(locationManager)
        
        return location
    }
    
    private func getStorageStrategy(){
        storageStrategy = strategyFactory.getStorageStrategy()
    }
    
    private func getLocationStrategy(){
        locationStrategy = strategyFactory.getLocationStrategy()
    }
}