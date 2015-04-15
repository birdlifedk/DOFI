//
//  DOFIService.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class DOFIService: WebserviceProtocol {

	func login(username: NSString, password:NSString) -> (ReturnMessage, User, [Trip]){
		let params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<NSString, NSString>
		var url:NSURL = NSURL(string: "http://dev.dofbasenweb/login")!

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

			if (res.statusCode >= 200 && res.statusCode < 300) {
				var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
				let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary
				let accessToken:NSString = jsonData.valueForKey("access_token") as! NSString
				let refreshToken:NSString = jsonData.valueForKey("refresh_token") as! NSString
				let expiresIn:Double = jsonData.valueForKey("expires_in") as! Double

				var token = Token(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn)

				url = NSURL(string: "http://dev.dofbasenweb/user/\(username)?access_token=\(token.accessToken)")!
				request = NSMutableURLRequest(URL: url)
				request.HTTPMethod = "GET"
				urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
				if ( urlData != nil ) {
					res = response as! NSHTTPURLResponse;
					if (res.statusCode >= 200 && res.statusCode < 300) {
						var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
						let jsonDataa:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary

						var user = User(id: 1 as NSInteger, name: "Andreas" as NSString, surname: "Sørensen" as NSString)
                        
                        var trips = [] // Vi skal vel også have trips tilbage ved login, eller er det separat?
                        
						Session.setUser(user)
						Session.setLoggedInStatus(true)
						//self.performSegueWithIdentifier("gotoWelcome", sender: self)

						var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
						prefs.setObject(Session.getUser().getUsername(), forKey: "USERNAME")
						prefs.setBool(Session.isLoggedIn(), forKey: "ISLOGGEDIN")
						prefs.synchronize()
                        
                        return (ReturnMessage(message: "Success!", isDone: true), user, trips as! [Trip])
                        
                    }else {
                        return (ReturnMessage(message: "second status code out of range", isDone: false), User(name: "", surname: ""), [])
                    }
                }else {
                    return (ReturnMessage(message: "second url data is nil", isDone: false), User(name: "", surname: ""), [])
                }
            }else {
               return (ReturnMessage(message: "first status code out of range", isDone: false), User(name: "", surname: ""), [])
            }
		}else {
            return (ReturnMessage(message: "first url data is nil", isDone: false), User(name: "", surname: ""), [])
        }
	}
    
    func storeObservation(userId: NSInteger, tripId: NSInteger, observation: Observation) -> ReturnMessage{
        var returnMessage = ReturnMessage(message: "Failed", isDone: false)
        
        return returnMessage
    }
}