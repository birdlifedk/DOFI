//
//  User.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

//
// The User class, representing af user.
//
public class User: RLMObject {

	var id = -1

	var username:NSString?

	var name:NSString?

	var surname:NSString?

	var token:Token?
}
