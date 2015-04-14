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

    init(){
        storageStrategy = strategyFactory.getStorageStrategy()
    }
    
	func login(username:NSString, password:NSString) -> (ReturnMessage, User, [Trip]){
		getStorageStrategy()
        return storageStrategy.login(username, password: password)
	}
    
    func storeObservation(userId:NSInteger, tripId:NSInteger, observation:Observation) -> ReturnMessage{
        getStorageStrategy()
        return storageStrategy.storeObservation(userId, tripId: tripId, observation: observation)
    }
    
    private func getStorageStrategy(){
        storageStrategy = strategyFactory.getStorageStrategy()
    }
}