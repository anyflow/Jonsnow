//
//  Json.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 2/16/16.
//  Copyright © 2016 Anyflow. All rights reserved.
//

import Foundation

class Json {
    private static let logger: Logger = Logger(className: "Json")

    static func toJsonString(target: AnyObject) -> String? {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(target, options: NSJSONWritingOptions.PrettyPrinted)
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
        }
        catch let error as NSError {
            logger.error(error.description)
            return nil;
        }
    }
}