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

class BreadingPairViewController: DOFIViewController, UITextViewDelegate {

	@IBOutlet var speciesText: UITextField!
	@IBOutlet var min: UITextField!
	@IBOutlet var max: UITextField!
	@IBOutlet var behaviour: UITextField!
	@IBOutlet var note: UITextView!
	@IBOutlet var map: MKMapView!

	var breadingPair = BreadingPair()

	override func viewDidLoad() {
		super.viewDidLoad()
		if(note != nil) {
			note.delegate = self
		}
	}

	func textViewDidEndEditing(textView: UITextView) {
		if(textView == note) {
			breadingPair.note = textView.text
		}
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
		println(Session.getTrip())
	}
}