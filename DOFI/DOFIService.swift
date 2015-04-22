//
//  DOFIService.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class DOFIService: WebserviceProtocol {

    let userMapper = UserMapper()
    let tokenMapper = TokenMapper()
    let tripMapper = TripMapper()
    
	func login(username: NSString, password:NSString) -> ReturnMessage{
		
        let params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<NSString, NSString>

		var token = tokenMapper.getToken(params)
        
        if (token.expiresIn > 0.0){
            Session.setToken(token)

            var user = userMapper.getUser(username, accessToken: Session.getToken().accessToken)
				
            if (user.id >= 0)
            {
                Session.setUser(user)
                Session.setLoggedInStatus(true)
                //self.performSegueWithIdentifier("gotoWelcome", sender: self)

                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                //prefs.setValue(user.user, forKey: "USER")
                prefs.setObject(["ID" : user.id, "USERNAME" : user.username!, "NAME" : user.name!, "SURNAME" : user.surname!], forKey: "USER")
                prefs.setBool(Session.isLoggedIn(), forKey: "ISLOGGEDIN")
                prefs.synchronize()
                        
                return ReturnMessage(message: "Success!", isDone: true, objects: [user])
            }else {
                return (ReturnMessage(message: "Kunne ikke hente en bruger", isDone: false, objects: nil))
            }
        }else {
            return (ReturnMessage(message: "Kunne ikke finde en brugbar access token", isDone: false, objects: nil))
        }
	}
    
    func getTrips(userId: NSInteger, accessToken: NSString) -> [Trip]{
        
        return tripMapper.getTrips()
    
    }
    
    func storeObservation(userId: NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        var returnMessage = ReturnMessage(message: "Failed", isDone: false, objects: nil)
        
        return returnMessage
    }
    
    func uploadContent(rlmResults: RLMResults) -> ReturnMessage{
        tripMapper.uploadContent(rlmResults)
        
        return ReturnMessage(message: "Test", isDone: false)
    }
}