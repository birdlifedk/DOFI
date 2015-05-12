//
//  ObservationViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 27/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class ObservationPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

	var origin:String = ""
	var index = 0
	var identifiers: NSArray = ["observationRequired", "observationExtra"]

	var obsPages: NSArray = ["observationRequired", "observationExtra"]
	var breadingPages: NSArray = ["breadingPairRequired", "breadingPairExtra"]
	var tripPages: NSArray = ["tripRequired", "tripExtra"]

	override func viewDidLoad() {
		super.viewDidLoad()

		self.dataSource = self
		self.delegate = self

		if(origin == "newObservation") {
			identifiers = obsPages

			self.navigationItem.title = "Observation"

			self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Tur", style:  UIBarButtonItemStyle.Plain, target:self, action: "tripHandler"), animated: false)
		}
		if(origin == "newBreadingPair") {
			identifiers = breadingPages
			self.navigationItem.title = "Ynglepar"

			self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Tur", style:  UIBarButtonItemStyle.Plain, target:self, action: "tripHandler"), animated: false)
		}
		if(origin == "tripSettings") {
			identifiers = tripPages
			self.navigationItem.title = "Tur"

			self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Historik", style:  UIBarButtonItemStyle.Plain, target:self, action: "historyHandler"), animated: false)
		}

		let startingViewController = self.viewControllerAtIndex(self.index)
		//let secondViewController   = self.viewControllerAtIndex(1)
		let viewControllers: NSArray = [startingViewController]
		self.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
	}

	func tripHandler() {
		var vc = self.storyboard?.instantiateViewControllerWithIdentifier("tripRequired") as! UIViewController
		vc.navigationItem.title = "Tur"
		vc.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Historik", style:  UIBarButtonItemStyle.Plain, target:self, action: "historyHandler"), animated: false)
		self.navigationController?.pushViewController(vc, animated: true)

	}

	func historyHandler() {
		var vc = self.storyboard?.instantiateViewControllerWithIdentifier("tripHistory") as! UIViewController
		self.navigationController?.pushViewController(vc, animated: true)
	}

	func viewControllerAtIndex(index: Int) -> UIViewController! {

		if (index < 0 || index > identifiers.count) {
			return nil
		} else {
			var vcName = identifiers[index] as! String
			return self.storyboard?.instantiateViewControllerWithIdentifier(vcName) as! UIViewController
		}
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

		let identifier = viewController.restorationIdentifier
		let index = self.identifiers.indexOfObject(identifier!)

		//if the index is 0, return nil since we dont want a view controller before the first one
		if index == 0 {
			return nil
		}

		//decrement the index to get the viewController before the current one
		return self.viewControllerAtIndex(--self.index)
	}

	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController)  -> UIViewController? {
		let identifier = viewController.restorationIdentifier

		let index = self.identifiers.indexOfObject(identifier!)

		if (index == identifiers.count-1) {
			return nil
		}
		return self.viewControllerAtIndex(++self.index)
	}

	func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
		return self.identifiers.count
	}

	func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
		return 0
	}
}
