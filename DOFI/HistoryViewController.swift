//
//  HistoryViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController, UITableViewDelegate {

	var communication = CommunicationFacade()

	var trips:[Trip] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		var trips = self.communication.getTrips()

		var testTrip1 = Trip()
		var testTrip2 = Trip()
		testTrip1.location = "Albertslund"
		testTrip1.interferenceQuantity = 10

		testTrip1.date = NSDate()
		testTrip2.date = NSDate()

		self.trips = [testTrip1, testTrip2]

		//self.trips[1] = testTrip2
	}

	
	override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
		let vc: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("tripHistoryDetails") as! UIViewController

		self.navigationController?.pushViewController(vc, animated: true)
		println("Icon pressed")
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		println("row selected")
		Session.sharedInstance.setTrip(self.trips[indexPath.row])
		self.navigationController?.popViewControllerAnimated(true)
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var test = self.trips
		return self.trips.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		var cell = tableView.dequeueReusableCellWithIdentifier("historyTableCell") as! UITableViewCell
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd/MM/YYYY" // - HH:mm
		var test = dateFormatter.stringFromDate(self.trips[indexPath.row].date!)

		var from = ""
		var to = ""
		if(self.trips[indexPath.row].time != nil) {
			from = self.trips[indexPath.row].time!.from
			to = self.trips[indexPath.row].time!.to
		}

		cell.textLabel!.text = "\(test)   \(from) - \(to)"

		return cell
	}
}