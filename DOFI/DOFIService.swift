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
    
	func login(username: NSString, password:NSString) -> ReturnMessage{
		let params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<NSString, NSString>
		var url:NSURL = NSURL(string: "http://dev.backbone/login")!

		var err: NSError?
		var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")

		var response: NSURLResponse?
		var responseError: NSError?

		var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&err)

		if ( urlData != nil ) {
			var res = response as! NSHTTPURLResponse;
            println(response)
            println(res)
            
			if (res.statusCode >= 200 && res.statusCode < 300) {
				var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
				

				var token = tokenMapper.getToken(urlData!)
                Session.setToken(token)

				url = NSURL(string: "http://dev.dofbasenweb/user/\(username)?access_token=\(Session.getToken().accessToken)")!
				request = NSMutableURLRequest(URL: url)
				request.HTTPMethod = "GET"
				urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
				if ( urlData != nil ) {
					res = response as! NSHTTPURLResponse;
					if (res.statusCode >= 200 && res.statusCode < 300) {
						var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!

						var user = userMapper.getUser(urlData!)
                        println(user)
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
                        return (ReturnMessage(message: "second status code out of range", isDone: false, objects: nil))
                    }
                }else {
                    return (ReturnMessage(message: "second url data is nil", isDone: false, objects: nil))
                }
            }else {
               return (ReturnMessage(message: "first status code out of range", isDone: false, objects: nil))
            }
		}else {
            return (ReturnMessage(message: "first url data is nil", isDone: false, objects: nil))
        }
	}
    
    func storeObservation(userId: NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        var returnMessage = ReturnMessage(message: "Failed", isDone: false, objects: nil)
        
        return returnMessage
    }
    
    func uploadContent(rlmResults: RLMResults) -> ReturnMessage{
        return ReturnMessage(message: "Test", isDone: false)
    }
}