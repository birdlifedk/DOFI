//
//  ObservationViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 06/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ObservationViewController: DOFIViewController, UITextFieldDelegate, UIPickerViewDelegate
{
	@IBOutlet var primaryBehaviourText: UITextField!
	@IBOutlet var secondaryBehaviourText: UITextField!
	@IBOutlet var directionText: UITextField!
	@IBOutlet var outfitText: UITextField!
	@IBOutlet var speciesText: UITextField!
	@IBOutlet var speciesQuantity: UITextField!
	@IBOutlet var fromTime: UIDatePicker!
	@IBOutlet var toTime: UIDatePicker!
	@IBOutlet var age: UITextField!
	@IBOutlet var suit: UITextField!
	@IBOutlet var observationNote: UITextView!
	@IBOutlet var observationMap: MKMapView!

	@IBOutlet var secondaryBehaviourPicker: UIPickerView! = UIPickerView()

	var annotation:MKPointAnnotation?
	var activeTextView: UITextField!
	var observation: Observation = Observation()

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
			initMap()
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

	override func viewDidAppear(animated: Bool) {
		if(observationMap != nil) {
			initMap()
		}
	}

	func initMap() {
		//self.map.delegate = self.mapDelegate
		var locations = self.communicationFacade.getLocation(self.locationManager)
		if(locations.longitude != nil ) {
			let location = CLLocationCoordinate2D(latitude: locations.latitude!, longitude: locations.longitude!)
			let span = MKCoordinateSpanMake(0.005, 0.005)
			let region = MKCoordinateRegion(center: location, span: span)

			self.observationMap.setRegion(region, animated: true)
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

	@IBAction func sliderHandler(sender: UISlider) {
		var value = sender.value
		let sex = ["M", "F"]
		if(value > 0.3 && value < 0.8) {
			sender.value = 0.5
		} else if (value <= 0.3) {
			sender.value = 0
		} else if (value >= 0.8) {
			sender.value = 1
		}
		observation.sex = sex[Int(value)]
		println(observation)
	}

	@IBAction func pinHandler(sender: UILongPressGestureRecognizer) {
		if(self.annotation == nil) {
			self.annotation = MKPointAnnotation()
			self.observationMap.addAnnotation(annotation)

		}
		var point:CGPoint = sender.locationInView(self.observationMap)
		var location = self.observationMap.convertPoint(point, toCoordinateFromView: self.observationMap)
		self.annotation!.coordinate = location
		self.annotation!.title = self.observation.species as String

		self.observation.location = location
	}

	@IBAction func formHandler(sender: AnyObject) {
		if(speciesText != nil && sender as! NSObject == speciesText) {
			observation.species = speciesText.text
		}
		if(speciesQuantity != nil && sender as! NSObject == speciesQuantity) {
			observation.quantity = (speciesQuantity.text as String).toInt()!
		}
		if(primaryBehaviourText != nil && sender as! NSObject == primaryBehaviourText) {
			observation.primaryBehaviour = primaryBehaviourText.text
		}
		if(secondaryBehaviourText != nil && sender as! NSObject == secondaryBehaviourText) {
			observation.secondaryBehaviour = secondaryBehaviourText.text
		}
		if((fromTime != nil && sender as! NSObject == fromTime) || (toTime != nil && sender as! NSObject == toTime)) {
			let dateFormatter = NSDateFormatter()
			dateFormatter.dateFormat = "hh:mm"
			var test = dateFormatter.stringFromDate(fromTime.date)
			observation.time = Time(from: dateFormatter.stringFromDate(fromTime.date), to: dateFormatter.stringFromDate(toTime.date))
		}
		if(directionText != nil && sender as! NSObject == directionText) {
			observation.direction = directionText.text
		}
		if(age != nil && sender as! NSObject == age) {
			observation.age = (age.text as String).toInt()!
		}
		if(suit != nil && sender as! NSObject == suit) {
			observation.suit = suit.text
		}
		println(observation)
	}

    @IBAction func confirmButtonHandler(sender: UIButton) {
        var trip = Trip()
        var observation = self.observation
        
//        var observation2 = Observation()
//        
//        trip.id = 1
//        observation.id = 1
//        observation2.id = 2
//        var test = communicationFacade.storeTrip(Session.getUser().id, trip: trip)
//        var returnMessage = communicationFacade.storeObservation(Session.getUser().id, trip: trip, observation: observation)
//        communicationFacade.storeObservation(Session.getUser().id, trip: trip, observation: observation2)
//        var localStorageTest = LocalStorageStrategy()
//        localStorageTest.uploadContent()
        //var returnMessage = communicationFacade.getLocation(self.locationManager)
        var returnMessage = communicationFacade.storeObservation(trip, observation: observation)
        println(returnMessage.message)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}