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

class BreadingPair: RLMObject {

	var species:NSString = ""

	var min:NSInteger = -1

	var max:NSInteger = -1

	var behaviour:NSString = ""

	var note:NSString = ""

	var location: CLLocationCoordinate2D?
	
}