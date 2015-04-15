//
//  ObservationViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 06/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import UIKit

class ObservationViewController: DOFIViewController, UITextFieldDelegate, UIPickerViewDelegate
{
	@IBOutlet var secondaryBehaviourText: UITextField!
	@IBOutlet var directionText: UITextField!
	@IBOutlet var outfitText: UITextField!

	@IBOutlet var secondaryBehaviourPicker: UIPickerView! = UIPickerView()

	var activeTextView: UITextField!

	var picks = [""]
	var secondaryBehaviours = ["1", "2"]
	var directions = ["d1", "d2", "d3"]

    
	override func viewDidLoad() {
		super.viewDidLoad()


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



        if(secondaryBehaviourText != nil && directionText != nil && secondaryBehaviourPicker != nil) {
            secondaryBehaviourText.delegate = self
            secondaryBehaviourText.inputView = secondaryBehaviourPicker
            secondaryBehaviourText.inputAccessoryView = toolbar

            directionText.delegate  = self
            directionText.inputView = secondaryBehaviourPicker
            directionText.inputAccessoryView = toolbar

            secondaryBehaviourPicker.delegate = self
            secondaryBehaviourPicker.hidden = true
            secondaryBehaviourPicker.showsSelectionIndicator = true
        }


	}

	func donePicker(sender:UIButton){
		activeTextView.text = picks[secondaryBehaviourPicker.selectedRowInComponent(0)]
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

	func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
	{
		activeTextView.text = picks[row]
	}

	func textFieldDidBeginEditing(textField: UITextField) {
		activeTextView = textField

		if(textField == secondaryBehaviourText) {
			picks = secondaryBehaviours
			secondaryBehaviourPicker.reloadAllComponents()
			secondaryBehaviourPicker.hidden = false
		}
		if(textField == directionText) {
			picks = directions
			secondaryBehaviourPicker.reloadAllComponents()
			secondaryBehaviourPicker.hidden = false
		}
	}

	func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

		return true
	}


    @IBAction func confirmButtonHandler(sender: UIButton) {
        var userId = Session.getUser().getId()
        var trip = Trip()
        var observation = Observation()
        
        var returnMessage = communicationFacade.storeObservation(userId, trip: trip, observation: observation)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}