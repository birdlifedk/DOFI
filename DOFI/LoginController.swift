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
		self.navigationController?.popViewControllerAnimated(true)
	}


}
