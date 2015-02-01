//
//  Model.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UiKit
import SwiftyJSON

class Model {
    typealias Success = (() -> Void)
    typealias Failure = ((error: NSError) -> Void)
    
    class func serializeToJson(object: AnyObject?) -> JSON? {
        if let object: AnyObject = object {
            return JSON(data: object as NSData)
        }
        return nil
    }
}
