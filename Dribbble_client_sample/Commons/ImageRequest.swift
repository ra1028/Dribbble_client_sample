//
//  ImageRequest.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import Alamofire

class ImageRequest {
    class var sharedRequest: ImageRequest {
        struct SharedInstance {
            static let instance = ImageRequest()
        }
        return SharedInstance.instance
    }
    
    func fetchImage(
        #imageUrl: String?,
        success: (UIImage? -> Void)? = nil,
        failure: (NSError? -> Void)? = nil
        ) {
            if let url = imageUrl {
                var req = request(.GET, url)
                req.response({ (
                    urlRequest,
                    urlResponse,
                    responseObject,
                    error: NSError?) -> Void in
                    if error == nil {
                        if let imageData = responseObject as? NSData {
                            let image = UIImage(data: imageData)
                            success?(image)
                        }
                    }else {
                        failure?(error)
                    }
                })
            }
    }
}