//
//  WebserviceAPICommunication.swift
//  DOFI
//
//  Created by Rasmus Rosted on 22/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class WebserviceAPICommunication {
    
    var userId = -1
    var accessToken = ""
    
    func getTokensAsJSONDictionary(params: Dictionary<NSString, NSString>) -> NSDictionary{
        
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
            //println(response)
            //println(res)
            
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                var responseError:NSError?
                return NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary
            }
            //println("getToken res.statusCode: " + res.statusCode.description)
            return NSDictionary()
        }
        //println("getToken: urlData == nil")
        return NSDictionary()
    }
    
    func getUserAsJSONDictionary(username: NSString, accessToken: NSString) -> NSDictionary{
        var url = NSURL(string: "http://dev.dofbasenweb/user/\(username)?access_token=\(accessToken)")!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var responseError: NSError?
        
        var urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&responseError)
        if ( urlData != nil ) {
            var res = response as! NSHTTPURLResponse;
            if (res.statusCode >= 200 && res.statusCode < 300) {
                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                
                var responseError:NSError?
                return NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary
            }
           // println("getUser res.statusCode: " + res.statusCode.description)
            return NSDictionary()
        }
      //  println("getUser: urlData == nil")
        return NSDictionary()
    }
    
    func getTripsAsJSONDictionary() -> NSDictionary{
		var urlPath = "http://dev.dofbasenweb/observation"
		var url: NSURL = NSURL(string: urlPath)!
		var request: NSURLRequest = NSURLRequest(URL: url)
		var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,
			startImmediately: false)!
        //getUserIdAndAccessToken()
		connection.start()

        return NSDictionary()
    }
    
    func uploadContent(dictionary: NSDictionary) -> ReturnMessage{
        //getUserIdAndAccessToken()
        
        var responseError:NSError?
        //var jsonData = NSJSONSerialization.
        
       // println("id: " + userId.description + "token: " + accessToken)
        
        return ReturnMessage(message: "Uploaded", isSuccess: true)
    }
    
    private func getUserIdAndAccessToken(){
        userId = Session.sharedInstance.getUser().id
        accessToken = Session.sharedInstance.getToken().accessToken as String
    }
}