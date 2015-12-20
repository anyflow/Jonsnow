//
//  User.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/15/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable{
    var id: String?
    var firstName: String?
    var lastName: String?
    var department: String?
    var phoneNumber: String?
    var createDate: NSDate?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        firstName   <- map["firstName"]
        lastName    <- map["lastName"]
        department  <- map["department"]
        phoneNumber <- map["phoneNumber"]
        createDate  <- map["createDate"]
    }
    
    var description: String {
        return "\r\nid           : \(id)\r\n"
            + "firstName    : \(firstName)\r\n"
            + "lastName     : \(lastName)\r\n"
            + "department   : \(department)\r\n"
            + "phoneNumber  : \(phoneNumber)\r\n"
            + "createDate   : \(createDate)"
    }
}