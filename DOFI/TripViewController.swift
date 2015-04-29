//
//  TripViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 20/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit

class TripViewController: DOFIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate {

	@IBOutlet var locationText: UITextField!
	@IBOutlet var tripDate: UIDatePicker!
	@IBOutlet var primaryView: UIView!
	@IBOutlet var secondaryView: UIView!
	@IBOutlet var fromTime: UIDatePicker!
	@IBOutlet var toTime: UIDatePicker!
	@IBOutlet var methodText: UITextField!
	@IBOutlet var methodPicker: UIPickerView! = UIPickerView()
	@IBOutlet var interferenceText: UITextField!
	@IBOutlet var tripNote: UITextView!
	@IBOutlet var interferenceQuantity: UITextField!
	@IBOutlet var interferenceNote: UITextView!

	var activeTextView: UITextField!

	var picks = [""]
	
	var delegate = AutoCompleteDelegate()

	var autocompleteTableView = UITableView(frame: CGRectMake(0,80,320,120), style: UITableViewStyle.Plain)

	var methods = ["Red", "Green", "Yellow"]
	var interferences = ["ja", "nej", "måske"]

	var locations: NSMutableArray = ["lok1", "lok2", "lok3"]
	var locationsAuto = [String]()

	var trip = Trip()

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

			self.delegate.locations = ["lok1", "lok2", "lok3"] as NSMutableArray
		}



		if(methodText != nil) {
			var toolbar = UIToolbar()
			toolbar.barStyle = UIBarStyle.Default
			toolbar.translucent = true
			toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
			toolbar.sizeToFit()

			var doneButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker:")
			var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
			var cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)//title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "canclePicker:")

			toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
			toolbar.userInteractionEnabled = true

			methodText.delegate = self
			methodText.inputView = methodPicker
			methodText.inputAccessoryView = toolbar

			interferenceText.delegate = self
			interferenceText.inputView = methodPicker
			interferenceText.inputAccessoryView = toolbar

			methodPicker.delegate = self
			methodPicker.hidden = true
			methodPicker.showsSelectionIndicator = true

			tripNote.delegate = self
			interferenceNote.delegate = self
		}
		//secondaryView.hidden = true
	}

	func donePicker(sender:UIButton){
		activeTextView.text = picks[methodPicker.selectedRowInComponent(0)]
		activeTextView.resignFirstResponder()
	}

	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
		return 1
	}

	// returns the # of rows in each component..
	func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
		return picks.count
	}

	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		return picks[row]
	}

	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		activeTextView.text = picks[row]
	}

	func textFieldDidBeginEditing(textField: UITextField) {
		activeTextView = textField

		if(textField == methodText) {
			picks = methods
			methodPicker.reloadAllComponents()
		}
		if(textField == interferenceText) {
			picks = interferences
			methodPicker.reloadAllComponents()
		}
		methodPicker.hidden = false

	}

	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
		return true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textViewDidEndEditing(textView: UITextView) {
		if(textView == tripNote) {
			trip.note = textView.text
		}
		if(textView == interferenceNote) {
			trip.interferenceNote = interferenceNote.text
		}
	}

	// When something is changed in a textfield, we store it in a trip object.
	@IBAction func formHandler(sender: AnyObject, forEvent event: UIEvent) {

		// @TODO get rit of some of the if's
		if(locationText != nil && sender as! NSObject == locationText) {
			trip.location = locationText.text
			println(trip)
		}

		if(tripDate != nil && sender as! NSObject == tripDate) {
			trip.date = tripDate.date
			println(trip)
		}

		if(methodText != nil && sender as! NSObject == methodText) {
			trip.method = methodText.text
		}

		if((fromTime != nil && sender as! NSObject == fromTime) || (toTime != nil && sender as! NSObject == toTime)) {
			let dateFormatter = NSDateFormatter()
			dateFormatter.dateFormat = "hh:mm"
			var test = dateFormatter.stringFromDate(fromTime.date)
			trip.time = Time(from: dateFormatter.stringFromDate(fromTime.date), to: dateFormatter.stringFromDate(toTime.date))
		}

		if(interferenceText != nil) {
			trip.interference = interferenceText.text
		}

		if(interferenceQuantity != nil) {
			trip.interferenceQuantity = (interferenceQuantity.text as String).toInt()
		}
	}

	// The submit button, terminates the view, and saves the current trip object in the Session struct.
	@IBAction func submitForm(sender: UIButton) {
        var trip = self.trip
        
        if (trip != nil){
            var tripValidation = trip.validate()
            
            if (tripValidation.isSuccess){
                Session.sharedInstance.setTrip(self.trip)
                self.navigationController?.popViewControllerAnimated(true)
            } else{
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Noget kig galt"
                alertView.message = tripValidation.message as String
                alertView.addButtonWithTitle("Ok")
                alertView.show()
            }
        } else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Noget kig galt"
            alertView.message = "Tur er nil"
            alertView.addButtonWithTitle("Ok")
            alertView.show()
        }
        
    }
}

class AutoCompleteDelegate: NSObject, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

	var activeText: UITextField?

	var activeTableView: UITableView?

	var locations: NSMutableArray = [""]
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