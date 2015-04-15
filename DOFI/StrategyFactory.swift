//
//  StrategyFactory.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class StrategyFactory {
    
    func getStorageStrategy() -> StorageStrategy{
        var connection = Reachability.reachabilityForInternetConnection()
        
        if(connection.isReachableViaWiFi()) {
            return OnlineStorageStrategy()
        } else {
            return LocalStorageStrategy()
        }
    }
    
    func getLocationStrategy() -> LocationStrategy{
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        
        var batteriLevel = batteryLevel()
        
        if(batteryLevel()>10)
        {
            return HighPrecisionLocationStrategy()
        }else {
            return LowPrecisionLocationStrategy()
        }
        //return NoConnectionLocationStrategi()
    }
    
    func batteryLevel()-> Float {
        
        return UIDevice.currentDevice().batteryLevel
    }
    
    
}