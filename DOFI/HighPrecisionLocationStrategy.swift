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
    func getLocation() -> Location{
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        var location = locationManager.location
        
        var coordinate = location.coordinate
        
        var latitude = coordinate.latitude
        
        var longitude = coordinate.longitude
        
        return Location(latitude: latitude, longitude: longitude)
    }
    
//    func locationManager(manager: CLLocationManager!,
//        didChangeAuthorizationStatus status: CLAuthorizationStatus)
//    {
//        if status == .AuthorizedWhenInUse {
//            manager.startUpdatingLocation()
//        }
//    }
}