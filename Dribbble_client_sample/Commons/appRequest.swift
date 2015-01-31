//
//  appRequest.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import RequestKit

class appRequest: Request {
    var dispatcher = Dispatcher()
    
    override var baseURL: NSURL? {
        return NSURL(string: "https://api.dribbble.com/v1")
    }
    
    override func appendDefaultParameters(parameters : [String: AnyObject]?) -> [String: AnyObject]? {
        let accessToken = "f5ec6b773bdb58ce5bb8465180c66194cfdcf744a2945dcbfaae9cd731299e17"
        if var parameters = parameters {
            parameters["access_token"] = accessToken
            return parameters
        }
        return parameters
    }
}