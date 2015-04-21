//
//  HighPrecisionLocationStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation

class HighPrecisionLocationStrategy: LocationStrategy {
    func getLocation(locationManager: CLLocationManager) -> Location{

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        var location = locationManager.location
        
        if (location == nil){
            locationManager.stopUpdatingLocation()
            return Location(latitude: nil, longitude: nil)
        }
        
        var coordinate = location.coordinate
        
        var latitude = coordinate.latitude
        
        var longitude = coordinate.longitude
        
        locationManager.stopUpdatingLocation()
        
        return Location(latitude: latitude, longitude: longitude)
    }
}