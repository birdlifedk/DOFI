//
//  BreadingPair.swift
//  DOFI
//
//  Created by Andreas Dahl on 22/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm
import MapKit

class BreadingPair: RLMObject, DOFIObject {

	var species:NSString = ""

	var min:NSInteger = -1

	var max:NSInteger = -1

	var behaviour:NSString = ""

	var note:NSString = ""

	var location: CLLocationCoordinate2D?
    
    func makeCopy() -> RLMObject {
        var breedingPair = BreadingPair()
        
        breedingPair.species = self.species
        breedingPair.min = self.min
        breedingPair.max = self.max
        breedingPair.behaviour = self.behaviour
        breedingPair.note = self.note
        breedingPair.location = self.location

        return breedingPair
    }
    
    func validate() -> ReturnMessage {
        var speciesValidationResult = validateSpecies()
        
        if (!speciesValidationResult.isSuccess){
            return speciesValidationResult
        }
        
        var intervalValidationResult = validateInterval()
        
        if (!intervalValidationResult.isSuccess){
            return intervalValidationResult
        }
        
        return ReturnMessage(message: "Valid", isSuccess: true)
    }
    
    func validateSpecies() -> ReturnMessage{
        
        if (species.length == 0){
            return ReturnMessage(message: "Art mangler at blive udfyldt", isSuccess: false)
        }
        
        return ReturnMessage(message: "Valid", isSuccess: true)
    }
	
    func validateInterval() -> ReturnMessage{
        
        if (min < 1){
            return ReturnMessage(message: "Der skal være minimum 1 ynglepar", isSuccess: false)
        }
        
        if (max < min){
            return ReturnMessage(message: "Maximum skal være større end minimum", isSuccess: false)
        }
        
        return ReturnMessage(message: "Valid", isSuccess: true)
    }
}