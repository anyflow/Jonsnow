//
//  Device.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/27/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class Device: Mappable {
    
    var deviceId: String
    var receiverId: String?
    var pushType: String
    var isActive: Bool?
    
    required convenience init?(_ map: Map) {
        self.init()
        
        mapping(map)
    }
    
    init() {
        deviceId = "6b0b38f1-2934-4e6e-a852-4efb0203c6b6"
        pushType = "APNS"
    }
    
    func mapping(map: Map) {
        deviceId    <- map["deviceId"]
        receiverId  <- map["receiverId"]
        isActive    <- map["isActive"]
        pushType    <- map["pushType"]
    }
    
    var jsonString: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}