//
//  StrategyFactory.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
class StrategyFactory {
    
    func getStorageStrategy() -> StorageStrategy{
        var connection = Reachability.reachabilityForInternetConnection()
        
        if(connection.isReachableViaWiFi()) {
            return OnlineStorageStrategy()
        } else {
            return LocalStorageStrategy()
        }
    }
    
    func getPositionStrategy() -> PositionStrategy{
        
    }
}