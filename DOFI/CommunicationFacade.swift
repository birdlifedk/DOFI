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
        self.startMonitoring(storageStrategy)
    }
    
    func startMonitoring(storageStrategy: StorageStrategy) {
        let queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
            var monitor = Monitor(storageStrategy: storageStrategy)
            monitor.start()
        }
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
    func storeObservation(userId:NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        return storageStrategy.storeObservation(userId, trip: trip, observation: observation)
    }
    
    func storeTrip(userId:NSInteger, trip: Trip) -> ReturnMessage{
        return storageStrategy.storeTrip(userId, trip: trip)
    }
    
    func getLocation(locationManager: CLLocationManager) -> Location{

        var location = locationStrategy.getLocation(locationManager)
        
        return location
    }
    
    func uploadContent() -> ReturnMessage{
        return ReturnMessage(message: "", isDone: false)
    }
}