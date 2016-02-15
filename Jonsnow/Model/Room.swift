//
//  Room.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/15/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import ObjectMapper

class Room: Mappable {

	var id: String?
	var isActive: Bool?
	var chats: [Chat]?
	var createDate: NSDate?

	required convenience init?(_ map: Map) {
		self.init()

		mapping(map)
	}

	init() {
	}

	func mapping(map: Map) {
		id <- map["id"]
		isActive <- map["isActive"]
		chats <- map["chats"]
		createDate <- map["createDate"]
	}

	var jsonString: String {
		return Mapper().toJSONString(self, prettyPrint: true)!
	}
}