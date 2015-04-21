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
    
    let dofbasenURL =  NSURL(string: "http://www.dofbasen.dk/opretmig.php")

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
			var returnMessage = login(username, password: password)
            
            if (returnMessage.isDone){
                closeSite()
            } else {
                var alert = UIAlertView()
                alert.title = "Fejl i login"
                alert.message = returnMessage.message as String
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
        }
    }

	func login(username:NSString, password:NSString) -> ReturnMessage{
		return self.communicationFacade.login(username, password: password)
    }
    
    func closeSite(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func newUserHandler(sender: UIButton) {
        UIApplication.sharedApplication().openURL(self.dofbasenURL!)
    }


}
