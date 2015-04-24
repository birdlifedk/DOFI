//
//  LocalStorageMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class LocalStorageMapper {
    let inMemoryStorage = DOFIInMemoryStorage()
    let localStorage = DOFILocalStorage()
    
    func deleteRLMObject(rlmObject: RLMObject) -> ReturnMessage{
        localStorage.delete(rlmObject)
        
        return ReturnMessage(message: "Done deleting", isDone: true)
    }
}