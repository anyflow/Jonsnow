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
	private static let logger: Logger = Logger(className: "Smpframe")

	var id: Int
	var opcode: Int
	var sessionId: String?

	required convenience init?(_ map: Map) {
		self.init(opcode: -1, id: -1, sessionId: "")

		mapping(map)
	}

	init(opcode: Int, id: Int, sessionId: String?) {
		self.opcode = opcode
		self.id = id
		self.sessionId = sessionId
	}

	func mapping(map: Map) {
		id <- map["pushframeId"]
		opcode <- map["opcode"]
		sessionId <- map["sessionId"]
	}

	var jsonString: String {
		return Mapper().toJSONString(self, prettyPrint: true)!
	}

    static func newJsonString(opcode: Int, id: Int, sessionId: String?, fields: [String: AnyObject]) -> String? {
        var dic = Mapper().toJSON(Smpframe(opcode: opcode, id: id, sessionId: sessionId));

        for (key, value) in fields {
            dic[key] = value;
        }
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dic, options: NSJSONWritingOptions.PrettyPrinted)
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
        }
        catch let error as NSError {
            logger.error(error.description)
            return nil;
        }
    }
}