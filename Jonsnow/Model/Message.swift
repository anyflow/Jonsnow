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
		unreadCount <- map["unreadCount"]
        
        let transform = TransformOf<NSDate, Double>(fromJSON: { (value: Double?) -> NSDate? in
            guard let value = value else {
                return nil
            }
            
            return NSDate(timeIntervalSince1970: value)
            }, toJSON: { (value: NSDate?) -> Double? in
                guard let value = value else {
                    return 0
                }
                return value.timeIntervalSince1970
        })
        
        createDate <- (map["createDate"], transform)
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