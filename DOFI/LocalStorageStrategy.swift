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

    let localStorageFacade = LocalStorageFacade()
    
	func login(username: NSString, password: NSString) -> (ReturnMessage, User, [Trip]){
		var alert = UIAlertView()
		alert.title = "Ingen internet?"
		alert.message = "Det ser ud til du ikke har forbindelse til internettet"
		alert.addButtonWithTitle("Ok")
		alert.show()
        
        return (ReturnMessage(message: "Det ser ud til du ikke har forbindelse til internettet", isDone: false), User(name: "", surname: ""), [])
        
	}
    
    func storeObservation(userId:NSInteger, tripId:NSInteger, observation:Observation) -> ReturnMessage{
        return localStorageFacade.storeObservation(userId, tripId: tripId, observation: observation)
    }
}