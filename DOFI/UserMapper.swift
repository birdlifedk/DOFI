//
//  UserMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class UserMapper: Mapper {
    
    func getUser(username: NSString, accessToken: NSString) -> User{
        
        let jsonData = webserviceAPICommunication.getUserAsJSONDictionary(username, accessToken: accessToken)
        
        if (jsonData.count == 0){
            return User()
        }
        var user = User()

        var id: String = jsonData.valueForKey("id") as! String
        
        user.id = id.toInt()!
        user.username = jsonData.valueForKey("obserkode") as? NSString
        user.name = jsonData.valueForKey("fornavn") as? NSString
        user.surname = jsonData.valueForKey("efternavn") as? NSString
    
        return user
    }
}