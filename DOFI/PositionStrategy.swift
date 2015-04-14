//
//  PositionStrategy.swift
//  DOFI
//
//  Created by Rasmus Rosted on 14/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

protocol PositionStrategy {
    
    func getPosition() -> Position
}