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
    
    func testSerialize() {
        
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
            
            let user = Mapper<User>().map(json)
            
            logger.debug(user?.description)
            
            if user == nil { return }
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(user!)
            }
            
            dispatch_sync(dispatch_queue_create("background", nil)) {
                let userRealm = realm.objects(User).first
                
                self.logger.debug(userRealm?.description)
            }
        }
        catch {
            logger.error("reading failed")
        }
        
    }
}