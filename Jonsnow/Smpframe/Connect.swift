//
//  Device.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/27/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class Connect: Smpframe {
    
    var deviceId: String
    var networkType: String
    
    init(id: Int, sessionId: String, deviceId: String, networkType: String) {
        self.deviceId = deviceId
        self.networkType = networkType

        super.init(opcode: 0, id: id, sessionId: sessionId)
    }

    required convenience init?(_ map: Map) {
        self.init(id: 0, sessionId: "", deviceId: "", networkType: "")
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        deviceId        <- map["deviceId"]
        networkType     <- map["networkType"]
    }
}