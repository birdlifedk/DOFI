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

	var index = 0
	var identifiers: NSArray = ["observationRequired", "observationExtra"]

	override func viewDidLoad() {
		super.viewDidLoad()

		self.dataSource = self
		self.delegate = self

		let startingViewController = self.viewControllerAtIndex(self.index)
		//let secondViewController   = self.viewControllerAtIndex(1)
		let viewControllers: NSArray = [startingViewController]
		self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)

	}

	func viewControllerAtIndex(index: Int) -> UIViewController! {

		if (index < 0 || index > identifiers.count) {
			return nil
		} else {
			var vcName = identifiers[index] as String
			return self.storyboard?.instantiateViewControllerWithIdentifier(vcName) as UIViewController
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

	func presentationCountForPageViewController(pageViewController: UIPageViewController!) -> Int {
		return self.identifiers.count
	}

	func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
		return 0
	}
}
