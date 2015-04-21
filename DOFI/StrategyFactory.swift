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
            return LocalStorageStrategy()
    }
    
    func getLocationStrategy() -> LocationStrategy{
            return HighPrecisionLocationStrategy()
    }
}