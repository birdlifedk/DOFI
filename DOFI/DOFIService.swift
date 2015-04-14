//
//  DOFIService.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class DOFIService: WebserviceProtocol {

	func login(username: NSString, password:NSString) -> (ReturnMessage, User, [Trip]) {
        var returnMessage = ReturnMessage(message: "", isDone: true)
        var user = User(name: "name", surname: "surname")
        var trips = [Trip(), Trip()]
		//var params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<String, String>
		//var url:NSURL = NSURL(string: "http://dev.dofbasenweb/login")!

		var err: NSError?
		var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")


		var response: NSURLResponse?
		var responseError: NSError?

		var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&err)

		//var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&err)
        
        return (returnMessage, user, trips)
	}
}