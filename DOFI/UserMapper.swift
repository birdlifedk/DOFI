//
//  UserMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class UserMapper {

    func getUser(urlData: NSData) -> User{
        var responseError:NSError?
        let jsonDataa:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary
        
        
        var newUser = User()
        println(jsonDataa)
        var id: String = jsonDataa.valueForKey("id") as! String
        
        newUser.id = id.toInt()!
        newUser.username = jsonDataa.valueForKey("obserkode") as? NSString
        newUser.name = jsonDataa.valueForKey("fornavn") as? NSString
        newUser.surname = jsonDataa.valueForKey("efternavn") as? NSString
    
        return newUser
    }
}