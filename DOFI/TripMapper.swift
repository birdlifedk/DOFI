//
//  TripMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class TripMapper: Mapper {
    
    func getTrips() -> [Trip]
    {
        var jsonData = webserviceAPICommunication.getTripsAsJSONDictionary()
        
        var trips = [Trip(), Trip()] as [Trip]
        
        return trips
    }
    
    func uploadContent(dictionary: NSDictionary) -> ReturnMessage{
        
        
        //Lav dictionary om til JSON
        
        
        return webserviceAPICommunication.uploadContent(dictionary)
    }
}