//
//  Request.swift
//  DOFI
//
//  Created by Andreas Dahl on 30/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

enum RequestMethod : String {

	case Get = "GET"
	case Post = "POST"
	case Delete = "DELETE"
	case Put = "PUT"
}

class Request {

	var method:RequestMethod!

	var body:String = ""

	var urlParams:String = ""

	func request(method: RequestMethod, params: NSDictionary, headers: NSDictionary?) {

		setMethod(method)
		setParams(params)

		
	}

	func setParams(params: NSDictionary) {
		if(self.method == .Get) {
			paramsToString(params)
		} else {
			paramsToJsonString(params)
		}

	}

	func paramsToString(params: NSDictionary) {
		var urlString = "?"

		for (key, value) in params {
			urlString += "\(key)=\(value)&"
		}

		self.urlParams = urlString
	}

	func paramsToJsonString(params: NSDictionary) {
		self.body += JSON(params).string!
	}



	func setMethod(method:RequestMethod) {
		self.method = method
	}







}