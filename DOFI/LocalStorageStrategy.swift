//
//  LocalStorageStrategy.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class LocalStorageStrategy: StorageStrategy {

	func login(username: NSString, password: NSString) {
		var alert = UIAlertView()
		alert.title = "Ingen internet?"
		alert.message = "Det ser ud til du ikke har forbindelse til internettet"
		alert.addButtonWithTitle("Ok")
		alert.show()
	}
}