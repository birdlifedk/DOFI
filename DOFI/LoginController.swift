//
//  LoginController.swift
//  DOFI
//
//  Created by Andreas Dahl on 10/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {

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
		var post:NSString = "username=\(username)&password=\(password)&client_id=2&client_secret=DOFISECRET&grant_type=password"
		var url:NSURL = NSURL(string: "http://dev.dofbasenweb/login")!
		var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
		var postLength:NSString = String(postData.length)

		var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		request.HTTPBody = postData
		request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")

		var reponseError: NSError?
		var response: NSURLResponse?

		var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
		


	}


}
