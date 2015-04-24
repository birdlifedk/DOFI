//
//  BreadingPairViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 22/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class BreadingPairViewController: DOFIViewController, UITextViewDelegate, UITextFieldDelegate, UIPickerViewDelegate {

	@IBOutlet var speciesText: UITextField!
	@IBOutlet var min: UITextField!
	@IBOutlet var max: UITextField!
	@IBOutlet var behaviour: UITextField!
	@IBOutlet var note: UITextView!
	@IBOutlet var map: MKMapView!
	@IBOutlet var picker: UIPickerView! = UIPickerView()

	var annotation: MKPointAnnotation?
	var activeTextView: UITextField!
	var picks = [""]
	var breadingPair = BreadingPair()
	var delegate = AutoCompleteDelegate()
	var tableView = UITableView(frame: CGRectMake(0,80,320,120), style: UITableViewStyle.Plain)
	var breadingPairBehaviour = ["Adfærd1", "Adfærd2", "Adfærd3"]
	var mapDelegate = DOFIMapDelegate()

	override func viewDidLoad() {
		super.viewDidLoad()
		if(note != nil) {
			note.delegate = self
		}

		if(speciesText != nil) {
			speciesText.delegate = self.delegate

			tableView.delegate = self.delegate
			tableView.dataSource = self.delegate
			tableView.scrollEnabled = true
			tableView.hidden = true

			self.view.addSubview(tableView)

			self.delegate.activeText = speciesText
			self.delegate.activeTableView = tableView
			self.delegate.locations = ["test1", "test2", "test3"] as NSMutableArray
		}

		if(behaviour != nil) {
			initMap()
			var toolbar = UIToolbar()
			toolbar.barStyle = UIBarStyle.Default
			toolbar.translucent = true
			toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
			toolbar.sizeToFit()

			var doneButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker:")
			var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
			var cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)

			toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
			toolbar.userInteractionEnabled = true

			behaviour.delegate = self
			behaviour.inputView = picker
			behaviour.inputAccessoryView = toolbar

			picker.delegate = self
			picker.hidden = true
			picker.showsSelectionIndicator = true

		}

	}

	override func viewDidAppear(animated: Bool) {
		if(map != nil) {
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

			map.setRegion(region, animated: true)
		}
	}

	func donePicker(sender:UIButton){
		activeTextView.text = picks[picker.selectedRowInComponent(0)]
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

		if(textField == behaviour) {
			picks = breadingPairBehaviour
			picker.reloadAllComponents()
		}
		picker.hidden = false
	}


	func textViewDidEndEditing(textView: UITextView) {
		if(textView == note) {
			breadingPair.note = textView.text
		}
	}

	@IBAction func pinHandler(sender: UILongPressGestureRecognizer) {
		if(self.annotation == nil) {
			self.annotation = MKPointAnnotation()
			map.addAnnotation(annotation)

		}
		var point:CGPoint = sender.locationInView(self.map)
		var location = self.map.convertPoint(point, toCoordinateFromView: self.map)
		self.annotation!.coordinate = location
		self.annotation!.title = self.breadingPair.species as String

		self.breadingPair.location = location
	}

	@IBAction func formHandler(sender: AnyObject) {
		// Just to make shure we only use objects that are available
		if(speciesText != nil) {
			if(sender as! NSObject == speciesText) {
				breadingPair.species = speciesText.text
			}
			if(sender as! NSObject == min) {
				breadingPair.min = (min.text as String).toInt()!
			}
			if(sender as! NSObject == max) {
				breadingPair.max = (max.text as String).toInt()!
			}
		}
		if(behaviour != nil) {
			if(sender as! NSObject == behaviour) {
				breadingPair.behaviour = behaviour.text
			}
		}
	}

	@IBAction func submitButtonHandler(sender: UIButton) {
		//Do some stuff here
		println(breadingPair)
		println(Session.sharedInstance.getTrip())
	}
}

class DOFIMapDelegate: NSObject, MKMapViewDelegate {

	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		var pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pinIdentifier")
		pin.canShowCallout = true



		return pin
	}
}