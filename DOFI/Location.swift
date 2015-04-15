//
//  Location.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    
    init (latitude: CLLocationDegrees?, longitude: CLLocationDegrees?)
    {
        self.latitude = latitude
        self.longitude = longitude
    }
}