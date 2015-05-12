//
//  DOFIService.swift
//  DOFI
//
//  Created by Andreas Dahl on 11/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import Realm

class DOFIService: NSObject {

	var data: NSMutableData = NSMutableData()
	var delegate: WebserviceProtocol?

    let userMapper = UserMapper()
    let tokenMapper = TokenMapper()
    let tripMapper = TripMapper()
    
	func login(username: NSString, password:NSString) -> ReturnMessage{
		
        let params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<NSString, NSString>

		var token = tokenMapper.getToken(params)
        
        if (token.expiresIn > 0.0){
            Session.sharedInstance.setToken(token)

            var user = userMapper.getUser(username, accessToken: Session.sharedInstance.getToken().accessToken)
				
            if (user.id >= 0)
            {
                Session.sharedInstance.setUser(user)
                Session.sharedInstance.setLoggedInStatus(true)
                //self.performSegueWithIdentifier("gotoWelcome", sender: self)

                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                //prefs.setValue(user.user, forKey: "USER")
                prefs.setObject(["ID" : user.id, "USERNAME" : user.username!, "NAME" : user.name!, "SURNAME" : user.surname!], forKey: "USER")
                prefs.setBool(Session.sharedInstance.isLoggedIn(), forKey: "ISLOGGEDIN")
                prefs.synchronize()
                        
                return ReturnMessage(message: "Success!", isSuccess: true, objects: [user])
            }else {
                return (ReturnMessage(message: "Kunne ikke hente en bruger", isSuccess: false, objects: nil))
            }
        }else {
            return (ReturnMessage(message: "Kunne ikke finde en brugbar access token", isSuccess: false, objects: nil))
        }
	}
    
    func getTrips(userId: NSInteger, accessToken: NSString) {
		var urlPath = "http://dev.dofbasenweb/observations"
		var url: NSURL = NSURL(string: urlPath)!
		var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "GET"

		var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,
			startImmediately: false)!


		connection.start()
    }
    
    func storeObservation(userId: NSInteger, trip: Trip, observation: Observation) -> ReturnMessage{
        var returnMessage = ReturnMessage(message: "Failed", isSuccess: false, objects: nil)
        
        return returnMessage
    }
    
    func uploadContent(dictionary: NSDictionary) -> ReturnMessage{
        
        return tripMapper.uploadContent(dictionary)
    }
	
	//NSURLConnection delegate method
	func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
		println("Failed with error:\(error.localizedDescription)")
	}

	//NSURLConnection delegate method
	func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
		//New request so we need to clear the data object
		self.data = NSMutableData()
	}

	//NSURLConnection delegate method
	func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
		//Append incoming data
		//println(data)
		//self.data.appendData(data)
	}

	//NSURLConnection delegate method
	func connectionDidFinishLoading(connection: NSURLConnection!) {
		//Finished receiving data and convert it to a JSON object
		//var err: NSError?
		//var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
		var jsonResult: NSDictionary = NSDictionary()
		delegate?.didRecieveResponse(jsonResult)

	}

}