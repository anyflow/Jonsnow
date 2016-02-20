//
//  Chat.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 1/17/16.
//  Copyright © 2016 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class Message: Object, Mappable {
    dynamic var id: String?
    dynamic var creatorId: String?
    dynamic var text: String?
    dynamic var createDate: NSDate?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        creatorId   <- map["creatorId"]
        text     <- map["text"]
        createDate  <- map["createDate"]
    }
    
    override var description: String {
        return "\n"
            + "id           : \(id)\n"
            + "creatorId    : \(creatorId)\n"
            + "text         : \(text)\n"
            + "createDate   : \(createDate)"
    }
}