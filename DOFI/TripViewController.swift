//
//  TripViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 20/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit

class TripViewController: DOFIViewController {

	@IBOutlet var locationText: UITextField!

	var delegate = AutoCompleteDelegate()

	var autocompleteTableView = UITableView(frame: CGRectMake(0,80,320,120), style: UITableViewStyle.Plain)
	
	@IBOutlet var primaryView: UIView!

	@IBOutlet var secondaryView: UIView!

	var colors = ["Red", "Green", "Yellow"]

	var locations: NSMutableArray = ["lok1", "lok2", "lok3"]
	var locationsAuto = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()

		if(locationText != nil ) {
			locationText.delegate = self.delegate

			autocompleteTableView.delegate = self.delegate
			autocompleteTableView.dataSource = self.delegate
			autocompleteTableView.scrollEnabled = true
			autocompleteTableView.hidden = true

			self.view.addSubview(autocompleteTableView)

			self.delegate.activeText = locationText
			self.delegate.activeTableView = autocompleteTableView
		}
		//secondaryView.hidden = true
	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return colors.count
	}

	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		return colors[row]
	}

	override func prefersStatusBarHidden() -> Bool {
		return true
	}


	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

class AutoCompleteDelegate: NSObject, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

	var activeText: UITextField?

	var activeTableView: UITableView?

	var locations: NSMutableArray = ["lok1", "lok2", "lok3"]
	var locationsAuto = [String]()

	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		println(activeTableView!.hidden)

		activeTableView!.hidden = false


		var substring = (activeText!.text as NSString).stringByReplacingCharactersInRange(range, withString: string)

		searchAutocompleteEntriesWithSubstring(substring)

		return true
	}

	func searchAutocompleteEntriesWithSubstring(substring: String) {
		locationsAuto.removeAll(keepCapacity: false)

		for curString in locations {
			var myString:NSString! = curString as! NSString

			var substringRange :NSRange! = myString.rangeOfString(substring)

			if (substringRange.location  == 0) {
				locationsAuto.append(curString as! String)
			}
		}
		activeTableView!.reloadData()
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return locationsAuto.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

		let autoCompleteRowIdentifier = "AutoCompleteRowIdentifier"
		var cell = tableView.dequeueReusableCellWithIdentifier(autoCompleteRowIdentifier) as? UITableViewCell

		if let tempo1 = cell {
			let index = indexPath.row as Int
			cell!.textLabel!.text = locationsAuto[index]
		} else {
			cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: autoCompleteRowIdentifier)
		}
		return cell!
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
		activeText!.text = selectedCell.textLabel!.text
		activeTableView?.hidden = true
		activeText!.resignFirstResponder()

	}

}