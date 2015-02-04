//
//  Player.swift
//  Dribbble_client_sample
//
//  Created by Ryo Aoyama on 2/4/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

class Player: NSObject {
    var id: Int?
    var name: String?
    var imageUrl: String?
    
    init(json: JSON) {
        super.init()
        self.update(json: json)
    }
    
    func update(#json: JSON) {
        if let value = json["id"].asInt { self.id = value }
        if let value = json["username"].asString { self.name = value }
        if let value = json["avatar_url"].asString { self.imageUrl = value }
    }
}