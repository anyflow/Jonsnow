//
//  Room.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/15/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class Channel: Mappable {

	var id: String?
	var name: String?
	var secretKey: String?
	var userIds: [String]?
	var createDate: NSDate?

	var messageReceived: ((message: Message) -> Void)?

	private var timeInterval: Double = 0

	required convenience init?(_ map: Map) {
		self.init()

		mapping(map)
	}

	init() {
	}

	func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
		secretKey <- map["secretKey"]
		userIds <- map["userIds"]
		timeInterval <- map["createDate"]

		createDate = NSDate(timeIntervalSince1970: timeInterval)
	}

	var jsonString: String {
		return Mapper().toJSONString(self, prettyPrint: true)!
	}
}