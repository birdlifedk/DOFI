//
//  TokenMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class TokenMapper {
    func getToken(urlData: NSData) -> Token{
        var responseError:NSError?
        let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData, options:NSJSONReadingOptions.MutableContainers , error: &responseError) as! NSDictionary
        
        let accessToken:NSString = jsonData.valueForKey("access_token") as! NSString
        let refreshToken:NSString = jsonData.valueForKey("refresh_token") as! NSString
        let expiresIn:Double = jsonData.valueForKey("expires_in") as! Double
        
        return Token(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn)
    }
}