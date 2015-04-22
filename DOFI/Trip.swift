//
//  Trip.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

public class Trip: RLMObject{
    
    var id = -1
    
    func makeCopy() -> Trip{
        var trip = Trip()
        trip.id = self.id
        
        return trip
    }
}