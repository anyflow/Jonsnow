//
//  ObjectMapperTest.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/17/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import XCTest
import ObjectMapper
import RealmSwift

@testable import Jonsnow


class ObjectMapperTests : XCTestCase {
    let logger: Logger = Logger(className : ObjectMapperTests.self.description())
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonConvert() {
        
        let filemgr = NSFileManager.defaultManager()
        
        let path = NSBundle.mainBundle().pathForResource("User", ofType: "json")
        
        logger.debug("path : \(path)")
        
        if filemgr.fileExistsAtPath(path!) == false {
            logger.error("The file not exist")
            return
        }
        
        do {
            let json = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)

            logger.debug("json : \(json as String)")
            
            guard let user = Mapper<User>().map(json) else {
                return
            }
            
            logger.debug(user.description)
            
            logger.debug(Mapper().toJSONString(user, prettyPrint: true))
        }
        catch {
            logger.error("reading failed")
        }
    }
    
    func testToJson() {
        let map = Map(mappingType: MappingType.FromJSON, JSONDictionary: ["receiverId": "testReceiverId", "isActive": true])
        let device = Device(map)
        
        logger.debug(Mapper().toJSONString(device!, prettyPrint: true))
    }
}