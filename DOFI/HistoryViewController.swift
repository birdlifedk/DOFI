//
//  HistoryViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 24/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController, UITableViewDelegate, WebserviceProtocol {

	@IBOutlet var historyTableView: UITableView!

	var communication = CommunicationFacade()

	var api: DOFIService = DOFIService()

	var trips:Dictionary<Int, Trip> = Dictionary<Int, Trip>()

	override func viewDidLoad() {
		super.viewDidLoad()

		api.delegate = self
		api.getTrips(Session.sharedInstance.getUser().id, accessToken: Session.sharedInstance.getToken().accessToken)

		//var trips = self.communication.getTrips()

		

		//self.trips = [testTrip1, testTrip2]

		//self.trips[1] = testTrip2
	}

	
	override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
		let vc: HistoryDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("tripHistoryDetails") as! HistoryDetailViewController
		vc.trip = self.trips[indexPath.row]
		self.navigationController?.pushViewController(vc, animated: true)
		println("Icon pressed")
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		println("row selected")
		Session.sharedInstance.setTrip(self.trips[indexPath.row]!)
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
		var test = dateFormatter.stringFromDate(self.trips[indexPath.row]!.date!)

		var from = ""
		var to = ""
		println(self.trips[indexPath.row]!.time)
		if(self.trips[indexPath.row]!.time != nil) {
			from = self.trips[indexPath.row]!.time!.from
			to = self.trips[indexPath.row]!.time!.to
		}

		cell.textLabel!.text = "\(test)   \(from) - \(to)"

		return cell
	}

	func didRecieveResponse(results: NSDictionary) {
		let dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "DK_da")
		dateFormatter.dateFormat = "dd/MM/yyyy"
		var testTrip1 = Trip()
		var svale = BreadingPair()
		svale.species = "Svale"
		svale.min = 1
		svale.max = 1


		var ørn = Observation()
		ørn.species = "Høgeørn"
		ørn.quantity = 1
		ørn.primaryBehaviour = "Syngende"

		var obs:Observation = Observation()
		obs.species = "Solsort"
		obs.quantity = 1
		obs.primaryBehaviour = "Syngende"
		testTrip1.location = "Enghaveparken (tidl. Enghaven)"
		testTrip1.observations[0] = obs
		testTrip1.observations[1] = ørn
		testTrip1.breadingPairs[0] = svale
		testTrip1.time = Time(from: "10:00", to: "11:00")

		var testTripH = Trip()
		testTripH.location = "Enghaveparken (tidl. Enghaven)"
		testTripH.time = Time(from: "14:00", to: "16:00")
		testTripH.date = dateFormatter.dateFromString("11/05/2015")
		println(testTripH.date)


		testTrip1.date = NSDate()
		self.trips = [0: testTrip1, 1: testTripH]
		self.historyTableView.reloadData()

		//self.trips = results as! Dictionary

	}
}