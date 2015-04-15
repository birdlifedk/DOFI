//
//  NoConnectionLocationStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class NoConnectionLocationStrategy: LocationStrategy {
    func getLocation() -> Location{
        return Location(latitude: nil, longitude: nil)
    }
}