//
//  ViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 15/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit

class ViewController: DOFIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib

		var nav = self.navigationController?.navigationBar

		nav?.barStyle = UIBarStyle.Black
		nav?.tintColor = UIColor.whiteColor()

		var color = UIColor(red: 0.6, green:0.0, blue: 0.0, alpha: 1.0)
		nav?.barTintColor = color
		nav?.backgroundColor = color

		let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

		let isLoggedIn:Bool = prefs.boolForKey("ISLOGGEDIN") as Bool

		if (!isLoggedIn) {
			self.performSegueWithIdentifier("goto", sender: self)
		} else {
			//self.usernameLabel.text = prefs.valueForKey("USERNAME") as NSString
		}

		self.startMonitoring()

	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)


	}

	func startMonitoring() {
		let queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

		dispatch_async(queue) {
			var monitor = Monitor()
			monitor.start()
		}
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


}

