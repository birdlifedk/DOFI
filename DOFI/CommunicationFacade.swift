//
//  CommunicationFacade.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class CommunicationFacade {

    var strategyFactory = StrategyFactory()
    
    var storageStrategy:StorageStrategy
    var locationStrategy:LocationStrategy

    init(){
        storageStrategy = strategyFactory.getStorageStrategy()
        locationStrategy = strategyFactory.getLocationStrategy()
    }
    
	func login(username:NSString, password:NSString) -> ReturnMessage{
		getStorageStrategy()
        return storageStrategy.login(username, password: password)
	}
    
    func storeObservation(userId:NSInteger, tripId:NSInteger, observation:Observation) -> ReturnMessage{
        getStorageStrategy()
        return storageStrategy.storeObservation(userId, tripId: tripId, observation: observation)
    }
    
    func getLocation() -> Location{
        getLocationStrategy()
        return locationStrategy.getLocation()
    }
    
    private func getStorageStrategy(){
        storageStrategy = strategyFactory.getStorageStrategy()
    }
    
    private func getLocationStrategy(){
        locationStrategy = strategyFactory.getLocationStrategy()
    }
}