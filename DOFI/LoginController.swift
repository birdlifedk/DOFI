//
//  LoginController.swift
//  DOFI
//
//  Created by Andreas Dahl on 10/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class LoginController: DOFIViewController {

	@IBOutlet var textUsername: UITextField!
	@IBOutlet var TextPassword: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func loginHandler(sender: UIButton) {
		var username:NSString = textUsername.text
		var password:NSString = TextPassword.text

		if(username.isEqualToString("") || password.isEqualToString("")) {
			var alertView:UIAlertView = UIAlertView()
			alertView.title = "Noget kig galt"
			alertView.message = "Du skal huske at skrive dit brugernavn og password"
			alertView.addButtonWithTitle("Ok")
			alertView.show()
		} else {
			login(username, password: password)
		}

	}

	func login(username:NSString, password:NSString) {
		self.communicationFacade.login(username, password: password)
		/*
		var post = "username=\(username)&password=\(password)&grant_type=password&client_id=2&client_secret=DOFISECRET"
		var params = ["username":username, "password":password, "grant_type":"password", "client_id": "2", "client_secret" : "DOFISECRET"] as Dictionary<String, String>

		var url:NSURL = NSURL(string: "http://dev.dofbasenweb/login")!
		var postData:NSData = post.dataUsingEncoding(NSUTF8StringEncoding)!
		var postLength:NSString = String(postData.length)
		var err: NSError?
		var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		request.HTTPBody = postData
		request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		//let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
			//data, response, error in

			//if error != nil {
			//	println("error=\(error)")
			//	return
			//}

			//println("response = \(response)")

			//let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
			//println("responseString = \(responseString)")
		//}
		//task.resume()






		var reponseError: NSError?
		var response: NSURLResponse?

		var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)

		if ( urlData != nil ) {
			var res = response as NSHTTPURLResponse;

			if (res.statusCode >= 200 && res.statusCode < 300) {
				var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
				let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &reponseError) as NSDictionary
				let accessToken:NSString = jsonData.valueForKey("access_token") as NSString
				let refreshToken:NSString = jsonData.valueForKey("refresh_token") as NSString
				let expiresIn:Double = jsonData.valueForKey("expires_in") as Double

				var token = Token(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn)

				url = NSURL(string: "http://dev.dofbasenweb/user/\(username)?access_token=\(token.accessToken)")!
				request = NSMutableURLRequest(URL: url)
				request.HTTPMethod = "GET"
				urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
				if ( urlData != nil ) {
					res = response as NSHTTPURLResponse;
					if (res.statusCode >= 200 && res.statusCode < 300) {
						var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
						let jsonDataa:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &reponseError) as NSDictionary

						var user = User(id: 1 as NSInteger, name: "Andreas" as NSString, surname: "Sørensen" as NSString)
						Session.setUser(user)
						Session.setLoggedInStatus(true)
						//self.performSegueWithIdentifier("gotoWelcome", sender: self)

						var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
						prefs.setObject(Session.getUser().getUsername(), forKey: "USERNAME")
						prefs.setBool(Session.isLoggedIn(), forKey: "ISLOGGEDIN")
						prefs.synchronize()

						self.navigationController?.popViewControllerAnimated(true)
						//self.dismissViewControllerAnimated(true, completion: nil)
					}
				}
			}
		}*/


	}


}
