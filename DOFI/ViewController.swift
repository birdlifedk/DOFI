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
		// Do any additional setup after loading the view, typically from a nib.


		var nav = self.navigationController?.navigationBar

		nav?.barStyle = UIBarStyle.Black
		nav?.tintColor = UIColor.whiteColor()

		var color = UIColor(red: 0.6, green:0.0, blue: 0.0, alpha: 1.0)
		nav?.barTintColor = color
		nav?.backgroundColor = color
        
        setupLocationManager()

	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)

		let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

		let isLoggedIn:Bool = prefs.boolForKey("ISLOGGEDIN") as Bool

		if (!isLoggedIn) {
			self.performSegueWithIdentifier("goto", sender: self)
		} else {
            var user = prefs.objectForKey("USER")
            
            var test = User(id: user?.valueForKey("ID") as! NSInteger, name: user?.valueForKey("NAME") as! NSString, surname: user?.valueForKey("SURNAME") as! NSString)
            
			Session.setUser(test)
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

    func setupLocationManager(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil){
                println("Error: " + error.localizedDescription)
                return
            }
            
            if (placemarks.count>0) {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }else {
                println("No placemarks")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark)
    {
        println(placemark.location.coordinate.latitude)
        println(placemark.location.coordinate.longitude)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Did fail with error: " + error.localizedDescription)
    }

}

