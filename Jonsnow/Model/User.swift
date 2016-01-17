//
//  User.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/15/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift

class User: Object, Mappable {
    dynamic var id: String?
    dynamic var name: String?
    dynamic var department: String?
    dynamic var dummy: String?
    //    dynamic var createDate: NSDate?
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        department  <- map["description"]
        dummy       <- map["friends"]
        //        createDate  <- map["createDate"]
    }
    
    override var description: String {
        return "\r\n"
            + "id           : \(id)\r\n"
            + "name         : \(name)\r\n"
            + "department   : \(department)\r\n"
        //             + "createDate   : \(createDate)"
    }
}