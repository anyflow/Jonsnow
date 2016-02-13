//
//  Device.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/27/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class Smpframe: Mappable {
    
    var id: Int
    var opcode: Int
    var sessionId: String
    
    required convenience init?(_ map: Map) {
        self.init(opcode: -1, id: -1, sessionId: "")
        
        mapping(map)
    }
    
    init(opcode: Int, id: Int, sessionId: String) {
        self.opcode = opcode
        self.id = id
        self.sessionId = sessionId
    }
    
    func mapping(map: Map) {
        id          <- map["pushframeId"]
        opcode      <- map["opcode"]
        sessionId   <- map["sessionId"]
    }
    
    var jsonString: String {
        return Mapper().toJSONString(self, prettyPrint: true)!
    }
}