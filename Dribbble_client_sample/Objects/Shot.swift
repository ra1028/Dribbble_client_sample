//
//  Shot.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/1/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import SwiftyJSON

class Shot: NSObject {
    var id: Int?
    var teaserUrl: String?
    var imageUrl: String?
    var summary: String?
    var title: String?
    
    init(json: JSON) {
        super.init()
        self.update(json: json)
    }
    
    func update(#json: JSON) {
        if let value = json["id"].asInt { self.id = value }
        if let value = json["images"]["teaser"].asString { self.teaserUrl = value }
        if let value = json["images"]["normal"].asString { self.imageUrl = value }
        if let value = json["description"].asString { self.summary = value }
        if let value = json["title"].asString { self.title = value }
    }
}