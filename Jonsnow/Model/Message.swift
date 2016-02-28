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
	var id: String?
	var channelId: String?
	var creatorId: String?
	var text: String?
	var createDate: NSDate?
	var unreadCount: Int?

	required convenience init?(_ map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		id <- map["id"]
		channelId <- map["channelId"]
		creatorId <- map["creatorId"]
		text <- map["text"]
		createDate <- map["createDate"]
		unreadCount <- map["unreadCount"]
	}

	override var description: String {
		return "\n"
			+ "id           : \(id)\n"
			+ "channelId    : \(channelId)"
			+ "creatorId    : \(creatorId)\n"
			+ "text         : \(text)\n"
			+ "createDate   : \(createDate)"
			+ "unreadCount  : \(unreadCount)"
	}
}