//
//  LowPrecisionLocationStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation

class LowPrecisionLocationStrategy: LocationStrategy, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    func getLocation() -> Location{
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        
        var location = locationManager.location
            
        var coordinate = location.coordinate
            
        var latitude = coordinate.latitude
            
        var longitude = coordinate.longitude
            
        return Location(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder.reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil){
                println(error.localizedDescription)
                return
            }
            
            if (placemarks.count>0) {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            }else {
                println()
            }
    })
    
    //    func locationManager(manager: CLLocationManager!,
    //        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    //    {
    //        if status == .AuthorizedWhenInUse {
    //            manager.startUpdatingLocation()
    //        }
    //    }

    }
    
    func displayLocationInfo (placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        println(placemark.location)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error.localizedDescription)
    }
}