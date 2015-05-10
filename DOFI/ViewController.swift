//
//  ViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 15/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: DOFIViewController, CLLocationManagerDelegate {
    
	override func viewDidLoad() {
		super.viewDidLoad()
		self.startMonitoring(self.communicationFacade.storageStrategy)
		// Do any additional setup after loading the view, typically from a nib

		var nav = self.navigationController?.navigationBar

		nav?.barStyle = UIBarStyle.Black
		nav?.tintColor = UIColor.whiteColor()

		var color = UIColor(red: 0.6, green:0.0, blue: 0.0, alpha: 1.0)
		nav?.barTintColor = color
		nav?.backgroundColor = color
        
        setupLocationManager()

		let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

		let isLoggedIn:Bool = prefs.boolForKey("ISLOGGEDIN") as Bool

		if (!isLoggedIn) {
			self.performSegueWithIdentifier("goto", sender: self)
		} else {
            var user: AnyObject? = prefs.objectForKey("USER")
            
            var sessionUser = User()
            sessionUser.id = user?.valueForKey("ID") as! NSInteger
            sessionUser.name = user?.valueForKey("NAME") as? NSString
            sessionUser.surname = user?.valueForKey("SURNAME") as? NSString
            //sessionUser.token = user?.valueForKey(<#key: String#>)
            
            println(Session.sharedInstance)
            
            Session.sharedInstance.setUser(sessionUser)
		}

	}

	func startMonitoring(storageStrategy: StorageStrategy) {
		let queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

		dispatch_async(queue) {
			var monitor = Monitor(storageStrategy: storageStrategy)
			monitor.start()
		}
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
	}

	

	override func prefersStatusBarHidden() -> Bool {
		return true
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier != "goto") {
			let vc:ObservationPageViewController = segue.destinationViewController as! ObservationPageViewController
			vc.origin = segue.identifier!
		}

	}

    func setupLocationManager(){
        self.locationManager.requestWhenInUseAuthorization()
    }

}

