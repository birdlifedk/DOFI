//
//  NoConnectionLocationStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation

class NoConnectionLocationStrategy: LocationStrategy {
    func getLocation(locationManager: CLLocationManager) -> Location{
        return Location(latitude: nil, longitude: nil)
    }
}