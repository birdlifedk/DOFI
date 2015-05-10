//
//  HistoryDetailViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 28/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit
import Realm

class HistoryDetailViewController: UITableViewController {

	@IBOutlet var historyDetailTable: UITableView!

	var inputs:[RLMObject] = []

	var trip:Trip?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.allowsMultipleSelectionDuringEditing = false;

		addRLMObjects()
	}


	//override func tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath -> Bool {
	// Return YES if you want the specified item to be editable.
	//return YES;
	//}

	func addRLMObjects() {

		for (key, value) in self.trip!.observations {
			self.inputs.append(value)
		}

		for (key, value) in self.trip!.breadingPairs {
			self.inputs.append(value)
		}
	}

	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}

	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if (editingStyle == UITableViewCellEditingStyle.Delete) {
			//add code here for when you hit delete
			self.inputs.removeAtIndex(indexPath.row)
			self.historyDetailTable.reloadData()
			println("Delete this motherfucker!")
		}
	}

	override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {

		println("Icon pressed")
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		println("row selected")
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.inputs.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell:UITableViewCell?

		if(self.inputs[indexPath.row] is Observation) {
			cell = getObservationCell(indexPath)
		}

		if(self.inputs[indexPath.row] is BreadingPair) {
			cell = getBreadingPairCell(indexPath)
		}
		
		return cell!
	}

	func getObservationCell(indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("historyTableDetailCell") as! UITableViewCell
		var obs = self.inputs[indexPath.row] as! Observation
		cell.textLabel?.text = "Art: \(obs.species) Antal: \(obs.quantity)"
		return cell
	}

	func getBreadingPairCell(indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier("historyTableDetailCell") as! UITableViewCell
		var bp = self.inputs[indexPath.row] as! BreadingPair
		cell.textLabel?.text = "Art: \(bp.species) Min: \(bp.min) Max: \(bp.max)"

		return cell
	}
}