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

class Trip: RLMObject, DOFIObject {

    var id = -1
    
	var location:NSString?

	var date:NSDate?

	var time:Time?

	var method:NSString?
	
	var note:NSString?

	var interference:NSString?

	var interferenceQuantity:NSInteger?

	var interferenceNote:NSString?

	var observations:Dictionary<Int, Observation> = Dictionary<Int, Observation>()

	var breadingPairs:Dictionary<Int, BreadingPair> = Dictionary<Int, BreadingPair>()
    
    func makeCopy() -> RLMObject{
        var trip = Trip()
        trip.id = self.id
        trip.location = self.location
        trip.date = self.date
        trip.time = self.time
        trip.method = self.method
        trip.note = self.note
        trip.interference = self.interference
        trip.interferenceQuantity = self.interferenceQuantity
        trip.interferenceNote = self.interferenceNote

        return trip
    }
    
    func validate() -> ReturnMessage {
        var returnMessage = ReturnMessage(message: "Valid", isSuccess: true)
        
        var locationValidationResult = validateLocation()
        
        if(!locationValidationResult.isSuccess){
            return locationValidationResult
        }
        
        return returnMessage
    }
    
    func validateLocation() -> ReturnMessage {
        var location = self.location
        if (location == nil) {
            return ReturnMessage(message: "En gyldig lokalitet mangler at blive valgt", isSuccess: false)
        }
        if (location!.length == 0){
            return ReturnMessage(message: "En gyldig lokalitet mangler at blive valgt", isSuccess: false)
        }
        
        return ReturnMessage(message: "Valid", isSuccess: true)
    }
}