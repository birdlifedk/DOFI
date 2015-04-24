//
//  Trip.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

struct Time {
    var from = "", to = ""
}

class Trip: RLMObject {

	var location:NSString?

	var date:NSDate?

	var time:Time?

	var method:NSString?
	
	var note:NSString?

	var interference:NSString?

	var interferenceQuantity:NSInteger?

	var interferenceNote:NSString?
    
    var id = -1
    
    func makeCopy() -> Trip{
        var trip = Trip()
        trip.id = self.id
        
        return trip
    }
}