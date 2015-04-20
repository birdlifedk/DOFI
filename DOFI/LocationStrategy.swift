//
//  LocationStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationStrategy {
    
    func getLocation(locationManager: CLLocationManager) -> Location
}