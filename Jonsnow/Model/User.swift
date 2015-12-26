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
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var department: String?
    dynamic var phoneNumber: String?
    dynamic var createDate: NSDate?
    
    required init?(_ map: Map) {
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    override init(value: AnyObject) {
        super.init(value:value)
    }
    
    override init(value: AnyObject, schema: RLMSchema) {
        super.init(value:value, schema:schema)
    }
    
    override init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm:realm, schema:schema)
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["firstName"]
        lastName    <- map["lastName"]
        department  <- map["department"]
        phoneNumber <- map["phoneNumber"]
        createDate  <- map["createDate"]
    }
    
    override var description: String {
        return "\r\n"
             + "id           : \(id)\r\n"
             + "firstName    : \(firstName)\r\n"
             + "lastName     : \(lastName)\r\n"
             + "department   : \(department)\r\n"
             + "phoneNumber  : \(phoneNumber)\r\n"
             + "createDate   : \(createDate)"
    }
}