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
	dynamic var name: String?
	dynamic var department: String?
	dynamic var dummy: String?

	required convenience init?(_ map: Map) {
		self.init()
	}

	func mapping(map: Map) {
		id <- map["id"]
		name <- map["name"]
		department <- map["description"]
		dummy <- map["friends"]
	}

	override var description: String {
		return "\n"
			+ "id           : \(id)\n"
			+ "name         : \(name)\n"
			+ "department   : \(department)"
	}
}