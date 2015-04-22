//
//  TokenMapper.swift
//  DOFI
//
//  Created by Rasmus Rosted on 21/04/15.
//  Copyright (c) 2015 DOF. All rights reserved.
//

import Foundation

class TokenMapper: Mapper {
    
    func getToken(urlData: Dictionary<NSString, NSString>) -> Token{
        
        let jsonData = webserviceAPICommunication.getTokensAsJSONDictionary(urlData)
        
        if (jsonData.count == 0){
            return Token(accessToken: "", refreshToken: "", expiresIn: 0.0)
        }
        
        let accessToken:NSString = jsonData.valueForKey("access_token") as! NSString
        let refreshToken:NSString = jsonData.valueForKey("refresh_token") as! NSString
        let expiresIn:Double = jsonData.valueForKey("expires_in") as! Double
        
        return Token(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn)
    }
}