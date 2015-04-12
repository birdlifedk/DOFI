//
//  TripViewController.swift
//  DOFI
//
//  Created by Andreas Dahl on 20/03/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import UIKit

class TripViewController: DOFIViewController {

	
	@IBOutlet var primaryView: UIView!

	@IBOutlet var secondaryView: UIView!

	var colors = ["Red", "Green", "Yellow"]

	override func viewDidLoad() {
		super.viewDidLoad()
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