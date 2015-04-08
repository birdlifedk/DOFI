//
//  ViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 15/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		setupSwipe()

		var nav = self.navigationController?.navigationBar

		nav?.barStyle = UIBarStyle.Black
		nav?.tintColor = UIColor.whiteColor()

		var color = UIColor(red: 0.6, green:0.0, blue: 0.0, alpha: 1.0)
		nav?.barTintColor = color
		nav?.backgroundColor = color

	}

	func setupSwipe() {
		var downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
		downSwipe.direction = .Down
		view.addGestureRecognizer(downSwipe)
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		let test = animated
	}

	func handleSwipes(sender:UISwipeGestureRecognizer) {
		if(sender.direction == .Down) {

			var navigation = self.navigationController?
			var storyboard = self.storyboard?
			var vc = storyboard?.instantiateViewControllerWithIdentifier("tripModal") as UITabBarController
			

			//self.navigationController?.showViewController(vc: UIViewController, sender: <#AnyObject!#>)

			navigation?.pushViewController(vc, animated: true)
			//performSegueWithIdentifier("tur", sender: nil)
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
		let vc:ObservationPageViewController = segue.destinationViewController as ObservationPageViewController
		vc.origin = segue.identifier!

	}


}

